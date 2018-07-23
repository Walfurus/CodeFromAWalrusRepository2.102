package  {
	import flash.display.MovieClip;
	
	public class Tile extends MovieClip {
		
		private var tileY:Number = 0;
		
		
		public function Tile():void {
			tileY = 0;
		}
		
		public function checkY():Number {
			return (tileY);
		}
		
	}
	
}
