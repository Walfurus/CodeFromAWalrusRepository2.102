package {

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;

	public class Main extends MovieClip {

		private var up:Boolean = false;
		private var left: Boolean = false;
		private var right: Boolean = false;

		public function Main() {
			setupEntity();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
			stage.addEventListener(Event.ENTER_FRAME, loopMove);
		}
		
		private var ply: Player = new Player();

		public function setupEntity(): void {
			trace("Im Sentient");
			ply.x += 300;
			ply.y += 200;
			addChild(ply);
		}
		
		private function keyPress(k: KeyboardEvent): void {
			if (k.keyCode == Keyboard.SPACE) {
				ply.jumpStart(30);
				up = true;
			}

			if (k.keyCode == Keyboard.A) {
				left = true;
			}

			if (k.keyCode == Keyboard.D) {
				right = true;
			}
		}

		private function keyRelease(k: KeyboardEvent): void {
			if (k.keyCode == Keyboard.SPACE) {
				ply.jumpStop();
			}

			if (k.keyCode == Keyboard.A) {
				left = false;
				ply.curSpeed = 0;
			}

			if (k.keyCode == Keyboard.D) {
				right = false
				ply.curSpeed = 0;
			}
		}

		public function loopMove(e:Event): void {
			ply.x += ply.curSpeed;
			
			if (up == true) {
				if (ply.gravSpeed > ply.gravMax) {
					ply.gravSpeed = ply.gravMax;
				} else {
					ply.gravSpeed += ply.gravAcc;
				}
				ply.y += ply.gravSpeed;
			}
			
			if (left == true) {
				ply.left();
			}
			if (right == true) {
				ply.right();
			}
		}
	}
}
