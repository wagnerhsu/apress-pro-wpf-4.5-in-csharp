   M S B A M L   `   `   `  ����P  LCustomControls, Version=1.0.4626.24769, Culture=neutral, PublicKeyToken=null/clr-namespace:CustomControlsCustomControls  5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089    CustomControls.FlipPanel  �� 
TargetType �� Property �� Value �� 
TargetType'  !System.Windows.VisualStateManager   VisualStateGroups%  System.Windows.VisualStateGroup   Transitions%  System.Windows.VisualTransition   GeneratedDuration	   To   
Storyboard	 �� 
TargetName
 �� TargetProperty	 W� To g� Duration   States   System.Windows.VisualState   
Storyboard � RowDefinitions ��Name    CornerRadius �� CornerRadius    FrontContent    BackContent d�Name J� RenderTransformOrigin �� Angle�� 5      D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    :x,http://schemas.microsoft.com/winfx/2006/xaml     5      &localclr-namespace:CustomControls  5      %  '         �� 5      "    6   .�5   
   ��  � �� 5      �� 5      "   6"   .R�5      �  5	        5
      
ViewStates�� 5   "     5   &   $ 0:0:0.7D�67   $ Flipped��6S   . 5   *   �� .��5   .   W� $	 FlipButtonTransform��6>   $
 Angle�5      $ 90X�6*   $ 0:0:0.2D�62   6G   5   +   5   '     5   &   $ 0:0:0.7D�67   $ Normal��6S   . 5   *   �� .��5   .   W� $	 FlipButtonTransform��6>   $
 Angle�5      $	 -90X�6*   $ 0:0:0.2D�63   6H   5   +   5   '   . 5   "     
Normal��. 5   &   �� .��5   *   W� $	 BackContent��6:   $
 Opacity�5      $ 0X�6<   $ 0D�6C   6S   5   '   5   #     5!   "   Flipped��. 5"   &   �� .��5#   *   W� $	 FlipButtonTransform��6:   $
 Angle�5$      $ 90X�6*   $ 0D�62   6A   W� 5%   *   $	 FrontContent��6:   $
 Opacity�5&      $ 0X�6<   $ 0D�6C   6R   5'   '   5(   #   5)       5,      �� 5-      $
��Auto �6,   6<   �� 5.      $
��Auto �6,   6<   .+�52      �� $ FrontContent��6!   #��z��67   #��z��53      # z 54      ._�56      �� #��z 57      58      59      �� 5<      $ BackContent��6!   #��z��66   #��z��5=      # z 5>      ._�5@      �� #��z 5A      5B      5C      d� 5F      $ 
FlipButton��64   $��1��6'   $ 0.5,0.5&�6H   $��0,10,0,0q�5G      $��19��6(   $��19��63   ��5H      �� 5I   "   .R�5J   &   � .+�5K   *   A� ���	#FFA9A9A9
�������6F   F� 5L   *   "����@B `� � �D @KL � z `� 	���	#FF666666$��2��5M   1   $��Center=�5N      $��Center=�6;   5P   +   5Q   '   5R   #   z�5U      �� 5W   "   FlipButtonTransform��$	 -90Q�6O   6]   5Z      5^      5`      5b      5c      5e      