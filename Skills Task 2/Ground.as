package  {
	
	import flash.display.MovieClip;
	
	public class Ground extends MovieClip {
		
		//private var killRange:Number = 500;
		public var returnBool:Boolean;
		
		public function checkHit(obj:MovieClip):Boolean {
			if (this.hitTestObject(obj)) {
				returnBool = true;
			} else {
				returnBool = false;
			}
			return (returnBool);
		}
		
		/*public function collide(objO:MovieClip, objP:MovieClip, loc:int):void {
			if (obj.x + obj.width / 2 > x - width
		}*/
	}
	
}
