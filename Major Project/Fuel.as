package  {
	import flash.display.MovieClip;
	
	public class Fuel extends MovieClip {
		
		private var ramp:Number = 0;
		
		public function Fuel() {
			this.amount.scaleX = ramp;
		}
		
		public function updateA(rt:Number):void {
			if (this.amount.scaleX > 0) {
				ramp = ramp - rt;
				this.amount.scaleX = ramp;
			} else {
				this.amount.scaleX = 0;
			}
		}
		
		public function resetF():void {
			ramp = 1;
			this.amount.scaleX = ramp;
		}
		
		public function checkV():Boolean {
			if (this.amount.scaleX == 0) {
				return true;
			} else {
				return false;
			}
		}
	}
}
