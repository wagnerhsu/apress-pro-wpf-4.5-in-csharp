using System;
using System.Threading;
using System.Windows;
using System.Windows.Threading;

namespace Multithreading
{
    public partial class Window1 : System.Windows.Window
    {
        Dispatcher dispatcher = Dispatcher.CurrentDispatcher;
        public Window1()
        {
            InitializeComponent();
        }

        private void cmdBreakRules_Click(object sender, RoutedEventArgs e)
        {
            Thread thread = new Thread(UpdateTextWrong);
            thread.Start();
        }

        private void UpdateTextWrong()
        {
            txt.Text = "Here is some new text.";
        }

        private void cmdFollowRules_Click(object sender, RoutedEventArgs e)
        {
            Thread thread = new Thread(UpdateTextRight);
            thread.Start();
        }

        private void UpdateTextRight()
        {
            Thread.Sleep(TimeSpan.FromSeconds(5));

            //this.Dispatcher.BeginInvoke(DispatcherPriority.Normal,
            //    (ThreadStart)delegate ()
            //   {
            //       txt.Text = "Here is some new text.";
            //   }
            //    );
            this.Dispatcher.BeginInvoke(DispatcherPriority.Normal, new Action(() => txt.Text = "Here is some new text."));
            //dispatcher.BeginInvoke(new Action(() => txt.Text = "Here is some new text."));
        }

        private void cmdBackgroundWorker_Click(object sender, RoutedEventArgs e)
        {
            BackgroundWorkerTest test = new BackgroundWorkerTest();
            test.ShowDialog();
        }
    }
}