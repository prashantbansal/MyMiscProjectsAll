using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestingDesignPrinciples
{
    public interface IOrder
    {
        int OrderNumber { get; set; }

        String OrderType { get; set; }

        IOrder GetOrderType(string OrderType);

        void GetOrderNumber();
    }

    public class Order : IOrder
    {
        public Order()
        { 
        }

        public Order(string orderType)
        {
            if (orderType.Equals("1"))
                new Order();
        }

        public int OrderNumber { get; set; }

        public String OrderType { get; set; }


        public IOrder GetOrderType(string OrderType)
        {
            if (OrderType.Equals("Order"))
                return new Order();
            return null;
        }

        public void GetOrderNumber()
        {
 
        }
    }

    public class PizzaOrder : Order
    {
        public static void RegisterProduct()
        { 
        }
        public PizzaOrder()
        { 
        }

        public PizzaOrder(string orderType)
        {
            if (orderType.Equals("2"))
                new PizzaOrder();
        }

        public new IOrder GetOrderType(string OrderType)
        {
            if (OrderType.Equals("PizzaOrder"))
                return new Order();
            return null;
        }
    }
}