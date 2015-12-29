using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PostSharp.Aspects;
using PostSharp.Extensibility;
using System.Diagnostics;


namespace TestingXml
{
    [Serializable]
    public sealed class TraceAttribute: OnMethodBoundaryAspect
    {
        private readonly string category;
        public TraceAttribute(string category)
        {
            this.category = category;
        }
        public string Category { get { return category; } }

        public override void OnEntry(MethodExecutionArgs args)
        {
            Trace.WriteLine("a", this.category);
        }

        public override void OnExit(MethodExecutionArgs args)
        {
            Trace.WriteLine("a", this.category);
        }
    }
}