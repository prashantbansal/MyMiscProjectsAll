using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestingDP
{
    public class Rectangle
    {
        protected int _width;
        protected int _height;

        public void SetHeight(int height)
        {
            this._height = height;
        }

        public void SetWidth(int width)
        {
            this._width = width;
        }

        public int GetHeight()
        {
            return this._height;
        }

        public int GetWidth()
        {
            return this._width;
        }

        public int GetArea()
        {
            return _width * _height;
        }
    }

    public class Square : Rectangle
    {
        public void SetHeight(int height)
        {
            this._height = height;
            this._width = height;
        }

        public void SetWidth(int width)
        {
            this._height = width;
            this._width = width;
        }

        public int GetArea()
        {
            return _width * _height;
        }
    }

    public class GetObject
    {
        public static Rectangle GetNewRectangle()
        {
            return new Square();
        }
    }
}
