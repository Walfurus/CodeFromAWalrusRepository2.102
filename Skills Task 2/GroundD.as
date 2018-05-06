package  {
	
	import flash.display.MovieClip;
	
	public class GroundD extends MovieClip {		//Just read the notes in Ground.as

		private var returnBool:Boolean;
		private var objID:int = 3;
		public var drop:Boolean = false;
		
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
