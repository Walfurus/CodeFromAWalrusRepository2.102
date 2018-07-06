package  {
	
	public class Utilities {

		public function randNum (minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
	}
	
}
