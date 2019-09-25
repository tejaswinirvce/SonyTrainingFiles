using NUnit.Framework;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NunitAssertTestDemo
{
    /// <summary>
    /// Assert class functionalities with classic & constraint Assert features
    /// Testing Todo
    /// 1.Given an input - a phrase - 
    /// 2.Count the number of a character(input)
    /// 3. Find out the number of words
    /// 4. Total of vowels in the phrase
    /// 5. Null,has,ignorecase - 
    /// 6.Use 2 types of assert functions - classic & constraint
    /// 7. Call the function and test it from a client
    /// 
    /// </summary>
    [TestFixture]
    public class AssertDemo
    {
        int x;
        [SetUp]
        public void FirstMethod()
        {
            x = 10;
        }


        [Test]
        public void IsNull()
        {
            object obj = null;
            //classic syntax
            Assert.IsNull(obj);

            //Constraint syntax
            Assert.That(obj, Is.Null);
        }

        [Test]
        public void IsNotNull()
        {
            //object obj = null;
            //classic syntax
            Assert.IsNotNull(50);

            //Constraint syntax
            Assert.That(50, Is.Not.Null);
        }

        [Test]
        public void IsTrue()
        {
            //object obj = null;
            //classic syntax
            Assert.IsTrue(4+4 == 8);
            Assert.That(Is.Equals( 2, 4));

            //Constraint syntax
            Assert.That(4+4==8, Is.True);
        }


        [Test]
        public void IsFalse()
        {
            //object obj = null;
            //classic syntax
            Assert.IsFalse(4 + 4 == 7);

            //Constraint syntax
            Assert.That(4 + 4 == 7, Is.False);
        }
        [Test]
        [Ignore("later..")]
        public void StringAssertFunc()
        {
            string sentence = "Hey there! whatsup?";
            Assert.AreEqual(typeof(string),"testing".GetType() );
            Assert.IsNotEmpty(new int[] { 10, 20, 30 });
            Assert.That(new int[] { 10, 20, 30 },Is
                .Not.Empty);

            Assert.That("Hello world how are you?", Does.Not.Contain("hello").IgnoreCase);
            StringAssert.StartsWith("Hey", sentence);
            StringAssert.EndsWith("whatsup?", sentence);

            Assert.That(sentence, Does.StartWith("Hey"));

        }
        [Test]

     
        public void ConstrainedAssertOnly()
        {
            object[] obj1 = new object[] { 10, 20, "5", null, "five" };
            string[] obj2 =  { "Apple", "Pear", "Oranges", "Peaches" };
            ArrayList arr = new ArrayList(obj1);
     
            
            //constrained assert
            Assert.That(arr, Has.Some.Null);

            Assert.That(arr, Has.Some.InstanceOf(typeof(int)));
            Assert.That(arr, Has.None.GreaterThan(50));

            //Assert.That(arr, Has.None.StartsWith("Ba"));
            Assert.That(obj2, Has.Property("Rank"));
            //Assert.That(obj2, Has.Property("Length").LessThan(5));


        }

        [Test]
       
        public void operatorsConstraint()
        {
            Assert.That(10, Is.GreaterThan(4) & Is.LessThan(20));
            Assert.That(10, Is.GreaterThan(4) | Is.LessThan(20));
            Assert.That(50, !Is.Null);
        }

        [TearDown]
        public void Cleanup()
        {
            x = 0;
        }

    }
}
