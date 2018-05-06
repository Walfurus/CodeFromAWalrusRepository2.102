package  {
	
	import flash.display.MovieClip;
	
	public class GroundC extends MovieClip {	//Read the notes in Ground.as

		private var returnBool:Boolean;
		private var objID:int = 2;
		
		public function checkHit(obj:MovieClip):Boolean {
			if (this.hitTestObject(obj)) {
				returnBool = true;
			} else {
				returnBool = false;
			}
			return (returnBool);
		}
		
		public function checkID():int {
			return (objID);
		}
	}
}