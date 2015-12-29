using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ninject;
using Ninject.Modules;

namespace TestingXml
{
    public class CheckingNinject: Ninject.Modules.NinjectModule
    {
        public override void Load()
        {
            Bind<IUser>().To<ConcreteUser>();
        }
    }

    public interface IUser
    {
        int GetEmpNo { get; set; }

        void GetUserDetails();
        
    }

    public class ConcreteUser : IUser
    {
        public int GetEmpNo { get; set; }

        public void GetUserDetails()
        {
            string userName = "a";
        }
    }

    public abstract class KernelFactoryBase
    {
        protected static IKernel CreateKernelFromModules(params NinjectModule[] modules)
        {
            var kernel = new StandardKernel(modules);
            return kernel;
        }
    }
}
