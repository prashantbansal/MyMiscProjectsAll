using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using NUnit.Framework;

namespace TestingSpecFlow.StepDefinitions
{
    [Binding]
    public class BindingSteps
    {
        protected double _firstValue;
        protected double _secondValue;
        protected double _total;
        protected double _PreviousValue;

        [Given("I have entered (.*) as first Value into computer")]
        public void IHaveEnteredFirstIntoComputer(double number)
        {
            _PreviousValue = number;
        }

        [Given("I have entered (.*) as Second value into computer")]
        public void IHaveEnteredSecondIntoComputer(double number)
        {
            _PreviousValue = _PreviousValue + number;
        }

        [Given("I entered (.*)")]
        public void IEnteredNumber(double number)
        {
            _PreviousValue += number;
        }

        [When("I press add")]
        public void IPressAdd()
        {

        }

        [Then("the result should be (.*) on the screen")]
        public void ThenTheResultShouldBe(double expectedAmount)
        {
            Assert.That(expectedAmount, Is.EqualTo(_PreviousValue));
        }


        [Given(@"I give number (.*)")]
        public void GivenIGiveNumber40(double input)
        {
            
        }

        [Given(@"It has to be divided by (.*)")]
        public void GivenItHasToBeDividedBy10()
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"My outcome should be 4")]
        public void ThenMyOutcomeShouldBe4()
        {
            ScenarioContext.Current.Pending();
        }

        [When(@"I press OK")]
        public void WhenIPressOK()
        {
            ScenarioContext.Current.Pending();
        }


        [Given(@"I have entered (.*) into the calculator1")]
        public void GivenIHaveEnteredIntoTheCalculator1(double input1)
        {
            _firstValue = input1;
        }

        [Given(@"I have entered (.*) into the calculator12")]
        public void GivenIHaveEnteredIntoTheCalculator12(double input2)
        {
            _secondValue = input2;
        }

        [Then(@"the result should be (.*) on the screen1")]
        public void ThenTheResultShouldBeOnTheScreen1(double expectedValue)
        {
            Assert.AreEqual(expectedValue, _firstValue + _secondValue);
        }

        [When(@"I press add1")]
        public void WhenIPressAdd1()
        {
            
        }
    }
}
