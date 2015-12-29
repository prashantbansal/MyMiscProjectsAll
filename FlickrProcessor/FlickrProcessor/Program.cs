using System;


namespace FlickrProcessor
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                Console.WriteLine("**Welcome to flickr Processor**");
                Console.WriteLine(string.Empty);
                Console.WriteLine("This application will provide MRSS feed for images based on your input");

                Console.WriteLine("The search will be made based on photos tagged in flickr");
                Console.WriteLine(string.Empty);
                Console.WriteLine("Please provide 'Tag' search criteria.");
                string tagValue = Console.ReadLine();

                while (string.IsNullOrEmpty(tagValue))
                {
                    Console.WriteLine("The value provided is not correct.");
                    Console.WriteLine("Please provide 'Tag' search criteria.");
                    tagValue = Console.ReadLine();
                }

                Console.WriteLine(string.Empty);

                //except tag, all values are hardcoded. It can be extended to have a input from user end
                string mrssPath = FlickrApiWrapper.ProcessPictures("1", "29096781@N02", "1", "100", tagValue);

                Console.WriteLine(string.Empty);
                Console.WriteLine("The MRSS Feed is generated and can be downloaded from " + mrssPath);
                Console.Read();
            }
            catch (Exception ex)
            {
                Console.WriteLine(string.Empty);
                Console.WriteLine("Exception occured while trying to get data from Flickr");
                Console.WriteLine(ex);
            }
        }
    }
}
