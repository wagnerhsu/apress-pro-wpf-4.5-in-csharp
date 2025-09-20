# PowerShell script to upgrade all .csproj files to .NET 8.0
param(
    [string]$RootPath = "e:\Github\apress\apress-pro-wpf-4.5-in-csharp\MyCode",
    [switch]$DryRun = $false
)

Write-Host "Starting upgrade of all .csproj files to .NET 8.0..." -ForegroundColor Green
Write-Host "Root path: $RootPath" -ForegroundColor Yellow
if ($DryRun) {
    Write-Host "DRY RUN MODE - No files will be modified" -ForegroundColor Yellow
}

# Find all .csproj files
$projFiles = Get-ChildItem -Path $RootPath -Recurse -Filter "*.csproj"
Write-Host "Found $($projFiles.Count) .csproj files" -ForegroundColor Cyan

$stats = @{
    LegacyConverted = 0
    SdkStyleUpdated = 0
    Errors = 0
    Skipped = 0
}

foreach ($projFile in $projFiles) {
    Write-Host "`nProcessing: $($projFile.FullName)" -ForegroundColor White
    
    try {
        $content = Get-Content $projFile.FullName -Raw
        $originalContent = $content
        
        # Check if it's already SDK-style project
        if ($content -match '<Project\s+Sdk=') {
            Write-Host "  -> SDK-style project detected" -ForegroundColor Magenta
            
            # Update TargetFramework to net8.0-windows for WPF projects
            if ($content -match '<TargetFramework>(net\d+\.\d+(?:-windows)?)</TargetFramework>') {
                $content = $content -replace '<TargetFramework>net\d+\.\d+(?:-windows)?</TargetFramework>', '<TargetFramework>net8.0-windows</TargetFramework>'
                Write-Host "  -> Updated TargetFramework to net8.0-windows" -ForegroundColor Green
                $stats.SdkStyleUpdated++
            }
            elseif ($content -match '<TargetFramework>net45</TargetFramework>') {
                $content = $content -replace '<TargetFramework>net45</TargetFramework>', '<TargetFramework>net8.0-windows</TargetFramework>'
                Write-Host "  -> Updated TargetFramework from net45 to net8.0-windows" -ForegroundColor Green
                $stats.SdkStyleUpdated++
            }
            else {
                Write-Host "  -> No TargetFramework update needed" -ForegroundColor Yellow
                $stats.Skipped++
            }
        }
        # Legacy format project - needs complete conversion
        elseif ($content -match '<TargetFrameworkVersion>v4\.5</TargetFrameworkVersion>') {
            Write-Host "  -> Legacy format project detected - converting to SDK-style" -ForegroundColor Magenta
            
            # Extract project name from file path
            $projectName = [System.IO.Path]::GetFileNameWithoutExtension($projFile.Name)
            
            # Determine if it's a WPF project by checking for WPF-specific elements
            $isWpfProject = $content -match 'ProjectTypeGuids.*60dc8134-eba5-43b8-bcc9-bb4bc16c2548' -or 
                           $content -match 'UseWPF.*true' -or
                           $content -match 'PresentationCore|PresentationFramework|WindowsBase'
            
            # Determine if it's an executable or library
            $isExecutable = $content -match '<OutputType>(?:WinExe|Exe)</OutputType>'
            
            # Create new SDK-style project content
            $newContent = @"
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0-windows</TargetFramework>
"@
            
            if ($isWpfProject) {
                $newContent += "`n    <UseWPF>true</UseWPF>"
            }
            
            if ($isExecutable) {
                $newContent += "`n    <OutputType>WinExe</OutputType>"
            }
            
            # Disable auto-generation of assembly attributes to avoid conflicts
            $newContent += "`n    <GenerateAssemblyInfo>false</GenerateAssemblyInfo>"
            
            # Disable deterministic build for wildcard versions
            $newContent += "`n    <Deterministic>false</Deterministic>"
            
            $newContent += "`n  </PropertyGroup>"
            
            # Add any package references that might be needed
            if ($content -match 'System\.AddIn') {
                $newContent += @"

  <ItemGroup>
    <Reference Include="System.AddIn" />
  </ItemGroup>
"@
            }
            
            $newContent += "`n</Project>"
            
            $content = $newContent
            Write-Host "  -> Converted to SDK-style with net8.0-windows target" -ForegroundColor Green
            $stats.LegacyConverted++
        }
        else {
            Write-Host "  -> Unknown project format, skipping" -ForegroundColor Yellow
            $stats.Skipped++
            continue
        }
        
        # Write the updated content if it changed
        if ($content -ne $originalContent) {
            if (-not $DryRun) {
                $content | Set-Content $projFile.FullName -NoNewline
                Write-Host "  -> File updated successfully" -ForegroundColor Green
            } else {
                Write-Host "  -> Would update file (DRY RUN)" -ForegroundColor Cyan
            }
        }
    }
    catch {
        Write-Host "  -> ERROR: $($_.Exception.Message)" -ForegroundColor Red
        $stats.Errors++
    }
}

# Print summary
Write-Host "`n" + ("="*50) -ForegroundColor Cyan
Write-Host "UPGRADE SUMMARY" -ForegroundColor Cyan
Write-Host ("="*50) -ForegroundColor Cyan
Write-Host "Total files processed: $($projFiles.Count)" -ForegroundColor White
Write-Host "Legacy projects converted: $($stats.LegacyConverted)" -ForegroundColor Green
Write-Host "SDK-style projects updated: $($stats.SdkStyleUpdated)" -ForegroundColor Green
Write-Host "Files skipped: $($stats.Skipped)" -ForegroundColor Yellow
Write-Host "Errors encountered: $($stats.Errors)" -ForegroundColor Red

if ($stats.Errors -eq 0) {
    Write-Host "`nUpgrade completed successfully!" -ForegroundColor Green
} else {
    Write-Host "`nUpgrade completed with errors. Please review the output above." -ForegroundColor Yellow
}

if ($DryRun) {
    Write-Host "`nTo perform the actual upgrade, run the script without the -DryRun parameter." -ForegroundColor Yellow
}