package TestPackage {
	public class TestClass {
		private var message:String;
		const TEST_VALUE:int = 20;
		public var TOTAL_VALUE:int = TEST_VALUE & 0xFF;

		public function TestClass(testQueue:String) {
            print("Test queue is: " + testQueue);
			message = "hello world";
		}

		public function printMessage() {
			print(message);
			print(TOTAL_VALUE);
		}
	}

    var queueParam:int = null;
	var x:TestClass = new TestClass(queueParam);
	x.printMessage();
}
