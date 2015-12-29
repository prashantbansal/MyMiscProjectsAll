using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestingDesignPrinciples
{
    public abstract class Shape
    {
        public abstract void Draw();
    }

    public class Rectangle : Shape
    {
        public override void Draw()
        {
            throw new NotImplementedException();
        }
    }

    public class Circle : Shape
    {
        public override void Draw()
        {
            throw new NotImplementedException();
        }
    }

    public class GraphicEditor
    {
        public void DrawShape(Shape shape)
        {
            shape.Draw();
        }
    }
}
