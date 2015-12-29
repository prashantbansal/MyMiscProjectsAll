using System.Collections.Generic;

namespace FlickrProcessor
{
    public static class FlickerAPIInput
    {
        public static List<FlickrInputModel> GetMethodsList()
        {
            List<FlickrInputModel> methodsList = new List<FlickrInputModel>();
            methodsList.Add(new FlickrInputModel { Id = "1", Description = "Search for Photos", Value = "flickr.photos.search" });
            methodsList.Add(new FlickrInputModel { Id = "1", Description = "Search for Photos marked public", Value = "flickr.people.getPublicPhotos" });

            return methodsList;
        }
    }
}
