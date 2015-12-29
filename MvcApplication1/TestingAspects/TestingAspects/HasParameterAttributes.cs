using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PostSharp.Aspects;
using System.Reflection;

namespace TestingAspects
{
    [Serializable]
    public class HasParameterAttributes : OnMethodBoundaryAspect  
    {
        public override void OnEntry(MethodExecutionArgs eventArgs)
        {
            ParameterInfo[] picolln = eventArgs.Method.GetParameters();
            Object[] args = eventArgs.Arguments.ToArray();

            for (int i = 0; i < picolln.Length; i++)
            {
                foreach (ParameterAttribute pa in picolln[i].Attributes)
                {
                    
                }
            }
        }

    }
}
