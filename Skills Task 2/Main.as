package {

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	import External;

	public class Main extends MovieClip {

		private var up:Boolean = false;
		private var left: Boolean = false;
		private var right: Boolean = false;
		
		private var platID:int = -1;
		private var platMax:int = 2;
		private var platNum:int = 0;
		
		private var spawnLoc:Number = 0;
		private var spawnLocAdd:Number = 300;
		
		private var external:External;
		
		private var platforms:Array = new Array();
		
		public function Main() {
			setupEntity();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
			stage.addEventListener(Event.ENTER_FRAME, globalLoop);
			
			external = new External();
			
			ply.buttonMode = true;
			//gnd.buttonMode = true;
		}
		
		private var ply:Player = new Player();
		
		//private var gndC:GndC = new GndC();
		
		public function setupEntity(): void {
			trace("Im Sentient");
			ply.x = 300;
			ply.y = 200;
			addChild(ply);
		}
		
		private function spawnPlat():void {
			var gnd:Ground = new Ground();
			
			gnd.x = spawnLoc;
			gnd.y = 600;
			addChild(gnd);
			platforms.push(gnd);
			trace ("hello there");
			trace (gnd.x);
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

		private function keyRelease(k:KeyboardEvent):void {
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

		public function globalLoop(e:Event): void {
			
			while (platNum < platMax) {
				spawnPlat();
				trace ("hi");
				platNum++
				spawnLoc = spawnLoc + spawnLocAdd;
			}
			
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
			
			for (var i:int;i<platforms.length;i++) {
				colS(ply,platforms[i]);
			}
			
		}
		
		public function colS(colDefP:Object, colDefO:Object): void {
			if (colDefO.hitTestObject(colDefP)) {
				if (colDefP.x - colDefP.width / 2 <= colDefO.x + colDefO.width && colDefP.x + colDefP.width / 2 >= colDefO.x + colDefO.width && colDefP.curSpeed < 0) {
					colDefP.x = colDefO.x + colDefO.width + 1 + colDefP.width / 2;
					colDefP.curSpeed = 0;
					left = false;
				}
				
				else if (colDefP.x + colDefP.width / 2 >= colDefO.x && colDefP.x - colDefP.width / 2 <= colDefO.x && colDefP.curSpeed > 0) {
					colDefP.x = colDefO.x - 1 - colDefP.width / 2;
					colDefP.curSpeed = 0;
					right = false;
				} else {
					if (colDefP.y - colDefP.height < colDefO.y) {
						colDefP.y = colDefO.y;
						colDefP.gravSpeed = 0;
					}
					
					if (colDefP.y > colDefO.y + colDefO.height && colDefP.gravSpeed < 0) {
						colDefP.y = colDefO.y + colDefO.height + colDefP.height;
						colDefP.gravSpeed = 0;
					}
				}
				colDefP.isJumping = false;
			}
		}
		
		/*public function colS(colDefP:MovieClip, colDefO:MovieClip): void {
			if (external.collide(colDefP,colDefO) == true) {
				if (colDefP.x - colDefP.width / 2 <= colDefO.x + colDefO.width && colDefP.x + colDefP.width / 2 >= colDefO.x + colDefO.width && colDefP.curSpeed < 0) {
					colDefP.x = colDefO.x + colDefO.width + 1 + colDefP.width / 2;
					colDefP.curSpeed = 0;
					left = false;
				}
				
				else if (colDefP.x + colDefP.width / 2 >= colDefO.x && colDefP.x - colDefP.width / 2 <= colDefO.x && colDefP.curSpeed > 0) {
					colDefP.x = colDefO.x - 1 - colDefP.width / 2;
					colDefP.curSpeed = 0;
					right = false;
				} else {
					if (colDefP.y - colDefP.height < colDefO.y) {
						colDefP.y = colDefO.y;
						colDefP.gravSpeed = 0;
					}
					
					if (colDefP.y > colDefO.y + colDefO.height && colDefP.gravSpeed < 0) {
						colDefP.y = colDefO.y + colDefO.height + colDefP.height;
						colDefP.gravSpeed = 0;
					}
				}
				colDefP.isJumping = false;
			}
		}*/
		
		
	}
}
