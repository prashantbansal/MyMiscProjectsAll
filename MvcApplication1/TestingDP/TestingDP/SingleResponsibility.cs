using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestingDP
{
    #region exampleOld
    interface IEmail
    {
        void SetSender(string sender);
        void SetReciever(string reciever);
        void SetContent(string content);
    }

    class Email : IEmail
    {
        public void SetSender(string sender)
        {

        }

        public void SetReciever(string reciever)
        {

        }

        public void SetContent(string content)
        {

        }
    }

    #endregion exampleOld

    #region WorkingExample
    interface IEmailWE
    {
        void SetSender(ISenderWE sender);
        void SetReciever(string reciever);
        void SetContent(IContent content);
    }

    interface ISenderWE
    {
        string FirstName { get; set; }
        string LastName { get; set; }
    }

    interface IContent
    {
        void GetDataAsString();
    }

    class EmailWE : IEmailWE
    {
        public void SetSender(ISenderWE sender)
        {

        }

        public void SetReciever(string reciever)
        {

        }

        public void SetContent(IContent content)
        {

        }
    }

    #endregion WorkingExample
}
