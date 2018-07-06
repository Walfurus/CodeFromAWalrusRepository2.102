package  {
	import flash.display.MovieClip;
	
	public class Tile extends MovieClip{
		
		public var objID:uint;
		public function Tile() {
			if (this.currentFrame == 1) {
				objID = 1;
				trace objID;
			}
		}

	}
	
}
