package  {
	
	import flash.display.MovieClip;
	
	
	public class DebugDoor extends MovieClip {
		
		public function left(sX:Number):void {
			this.x += sX;
		}
		
		public function right(sX:Number):void {
			this.x -= sX;
		}
		
		public function up(sY:Number):void {
			this.y += sY;
		}
		
		public function down(sY:Number):void {
			this.y -= sY;
		}
	}
}
