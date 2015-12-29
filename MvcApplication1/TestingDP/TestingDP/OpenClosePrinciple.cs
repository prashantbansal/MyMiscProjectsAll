using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestingDP.OpenClosePrinciple
{
    public class GraphicEditor
    {
        public void DrawShape(ShapeOCP s)
        {
            s.Draw();
        }
    }
    public abstract class ShapeOCP
    {
        public abstract void Draw();
    }

    public class rectangle : ShapeOCP
    {
        public override void Draw()
        {
            //draws rectangle
        }
    }

    public class Square : ShapeOCP
    {
        public override void Draw()
        {
            throw new NotImplementedException();
        }
    }

    
}
