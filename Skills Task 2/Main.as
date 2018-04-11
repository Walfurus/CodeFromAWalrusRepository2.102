package {

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.system.System;
	
	import External;
	import flash.text.engine.SpaceJustifier;

	public class Main extends MovieClip {

		private var up:Boolean = false;
		private var left: Boolean = false;
		private var right: Boolean = false;
		
		private var platID:int = -1;
		private var platMax:int = 3;
		private var platNum:int = 0;
		private const bkgXSize:Number = 2283.9;
		
		private var endAlpha:Number = 1;
		
		private var isContact:Boolean = false;
		
		private var gndBool:Boolean = false;
		private var gndSpeed:Number = 5;
		
		private var plyScore:Number = 0;
		
		private var spawnLoc:Number = 300;
		private var spawnLocAdd:Number;
		//private var yAdd:Number = 100;
		//private var spawnY:Number = 400;
		
		private var jumpSet:Boolean = false;
		
		private var gameStart:Boolean = false;
		
		private var external:External;
		
		private var platforms:Array = new Array();
		
		public function Main() {
			stop();
			external = new External();
			startGame.addEventListener(MouseEvent.MOUSE_UP, initGame);
			helpGame.addEventListener(MouseEvent.MOUSE_UP, needHelp);
			quitGame.addEventListener(MouseEvent.MOUSE_UP, letsQuit);
			
		}
		private function initGame(e:MouseEvent):void {
			setupEntity();
			gotoAndStop(2);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
			stage.addEventListener(Event.ENTER_FRAME, globalLoop);
		}
		
		private function needHelp(e:MouseEvent):void {
			gotoAndStop(61);
			backGame.addEventListener(MouseEvent.MOUSE_UP, moveBack);
			quitGame.addEventListener(MouseEvent.MOUSE_UP, letsQuit);
		}
		
		private function moveBack(e:MouseEvent):void {
			gotoAndStop(1);
			startGame.addEventListener(MouseEvent.MOUSE_UP, initGame);
			helpGame.addEventListener(MouseEvent.MOUSE_UP, needHelp);
			quitGame.addEventListener(MouseEvent.MOUSE_UP, letsQuit);
		}
		
		private function letsQuit(e:MouseEvent):void {
			System.exit(0);
		}
		
		private var ply:Player = new Player();
		private var plyM:PlyMask = new PlyMask();
		private var sPlat:SPlat = new SPlat();
		private var bkgL:BkgL = new BkgL();
		private var bkgR:BkgR = new BkgR();
		
		//private var gndC:GndC = new GndC();
		
		public function setupEntity(): void {
			trace("Im Sentient");
			plyM.gotoAndStop(1);
			bkgL.x = 0;
			bkgL.y = 0;
			addChild(bkgL);
			bkgR.x = bkgXSize;
			addChild(bkgR);
			setupPly();
			sPlat.x = ply.x;
			sPlat.y = ply.y;
			addChild(sPlat);
			
			spawnPlat(300);
			spawnPlat(800);
			spawnPlat(1300);
			spawnPlat(1800);
			spawnPlat(2300);
		}
		
		private function setupPly():void {
			ply.x = 300;
			ply.y = 100;
			addChild(ply);
			addChild(plyM);
			ply.alpha = 0;
		}
		
		private function spawnPlat(spawnInt:Number):void {
			var gnd:Ground = new Ground();
			gnd.x = spawnInt;
			gnd.y = external.randNum(150,600);
			
			addChild(gnd);
			platforms.unshift(gnd);
			trace ("hello there");
			platNum++
		}
		
		private function keyPress(k: KeyboardEvent): void {
			if (k.keyCode == Keyboard.SPACE && gameStart == true) {
				if (left == true && ply.isJumping == false) {
					plyM.gotoAndStop(4);
				} else if (right == true && ply.isJumping == false) {
					plyM.gotoAndStop(3);
				} else {
					if (plyM.currentFrame == 2) {
						plyM.gotoAndStop(4);
					} else {
						plyM.gotoAndStop(3);
					}
				}
				
				ply.jumpStart(30);
				ply.checkDJump(30);
				up = true;
			} else if (k.keyCode == Keyboard.SPACE) {
				ply.jumpStart(10);
				sPlat.alpha = 0.5;
				up = true;
			}

			if (k.keyCode == Keyboard.A) {
				left = true;
				plyM.gotoAndStop(2);
			} 
			if (k.keyCode == Keyboard.D) {
				right = true;
				plyM.gotoAndStop(1);
			} 
		}

		private function keyRelease(k:KeyboardEvent):void {
			if (k.keyCode == Keyboard.SPACE && gameStart == true) {
				if (left == true) {
					plyM.gotoAndStop(2);
				} else if (right == true) {
					plyM.gotoAndStop(1);
				} else {
					if (plyM.currentFrame == 4) {
						plyM.gotoAndStop(2);
					} else {
						plyM.gotoAndStop(1);
					}
				}
				
				ply.jumpStop();
				jumpSet = true;
			} else if (k.keyCode == Keyboard.SPACE) {
				sPlat.alpha = 0;
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
		
		private function endLoop(e:Event):void {
			endAlpha = endAlpha - 0.015;			
			for (var i:int;i<platforms.length;i++) {
				platforms[i].alpha = endAlpha;
				
				if (endS.currentFrame == 90) {
					gotoAndPlay(3);
					endS.gotoAndStop(1);
					bkgL.y = 9000;
					bkgR.y = 9000;
				}
				
				if (this.currentFrame == 60) {
					stop();
					endTxt.text = String(plyScore);
					removeEventListener(Event.ENTER_FRAME, endLoop);
				}
			}
		}
		
		private function endGame():void {
			addChild(endS);
			endS.gotoAndPlay(1);
		}
		
		var endS:EndScreen = new EndScreen();

		public function globalLoop(e:Event): void {
			
			while (platNum < platMax && gndBool == true) {
				spawnPlat(external.randNum(1000,1300));
				trace ("hi");
			}
			
			score.text = String(plyScore);
			
			stage.focus = stage;
			
			if (ply.x <= 0) {
				ply.x = 0;
			}
			
			if (ply.x >= 960) {
				ply.x = 960;
			}
			
			if (ply.y >= 720) {
				endGame();
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyRelease);
				stage.removeEventListener(Event.ENTER_FRAME, globalLoop);
				addEventListener(Event.ENTER_FRAME, endLoop);
			}
			
			if (gameStart == true) {
				bkgL.x -= gndSpeed;
				bkgR.x -= gndSpeed;
			} else {
				sPlat.x = ply.x;
			}
			
			if (bkgL.x <= -bkgXSize) {
				bkgL.x = bkgR.x + bkgXSize;
			}
			
			if (bkgR.x <= -bkgXSize) {
				bkgR.x = bkgL.x + bkgXSize;
			}
			//trace (ply.gravSpeed);
			
			plyM.x = ply.x;
			plyM.y = ply.y;
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
				
				if (gameStart == true) {
					platforms[i].x -= gndSpeed;
				}
				
				//---------------------------------------------------------
				//Would only work for static non spawning platforms
				//Vertical Screen Scroll Code
				/*if (ply.y >= 530) {
					platforms[i].y -= ply.gravSpeed;
					if (ply.y >= 590) {
						ply.y -= ply.gravSpeed;
					}
				}
				
				if (ply.y <= 80) {
					platforms[i].y -= ply.gravSpeed;
					if (ply.y <= 70) {
						ply.y += Math.abs(ply.gravSpeed);
					}
				}*/
				//----------------------------------------------------------
				//trace (platforms[i].returnBool);
			
				if (platforms[i].checkHit(ply) == true) {
					
					if (left == false && right == false) {
						ply.x -= gndSpeed;
						gameStart = true;
					} else if (left == true) {
						ply.x -= gndSpeed;
						gameStart = true;
					} else if (right == true) {
						gameStart = true;
					}
				}
				
				if (platforms[0].x < 500 && gameStart == true) {
					gndBool = true;
				} else {
					gndBool = false;
				}
				
				if (platforms[i].x < -400) {
					platforms.removeAt(i);
					platNum--
					plyScore++
					if (gndSpeed <= 25) {
						gndSpeed = gndSpeed + 1;
						trace (gndSpeed);
					}
				}
			}
		}
		
		//Local Collision Handler
		private function colS(colDefP:Object, colDefO:Object): void {
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
				colDefP.dJump = false;
			}
		}
		
		//Pointless, Remove for Final Product
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
