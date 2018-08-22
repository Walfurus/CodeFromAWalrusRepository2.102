
package  {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.system.System;
	import Utilities;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Main extends MovieClip {
		
		private var left: Boolean = false;
		private var right: Boolean = false;
		private var jUp:Boolean = false;
		private var up:Boolean = false;
		private var down:Boolean = false;
		private var drop:Boolean = false;
		//private var jumpSet:Boolean = false;
		private var util:Utilities;
		
		//private var jmp = 30;
		
		private var ply:Player = new Player();
		private var map:Map = new Map();
		
		private var colTArray:Array = new Array();
		private var lvlSelect:uint = 1;
		
		public function Main() {
			stage.addEventListener(Event.ENTER_FRAME, globalLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
			//forwards.addEventListener(MouseEvent.CLICK, fwdCom);
			//execute.addEventListener(MouseEvent.CLICK, runCommands);
			setupPly();
			stop();
			util = new Utilities();
			inital();
		}
		
		private function inital():void {
			lvlConstruct(0);
			jUp = true;
			//lvlDestruct();
		}
		
		private function lvlConstruct(lvl:int):void {
			switch (lvl) {
				case 0:
					spawnPlat(52.5,563.45,2);
					spawnPlat(387.5,381.5,1);
					spawnPlat(609.5,222.55,1);
					spawnPlat(609.5,222.55,1);
					spawnPlat(971.45,515.45,2);
					spawnPlat(1820.35,357.5,1);
					spawnPlat(2417.3,598.45,2);
					spawnPlat(3227.2,399.5,1);
					spawnPlat(3738.2,187.55,1);
					spawnPlat(4299.15,-47.45,2);
					spawnPlat(3403.95,1244.45,0);
					spawnPlat(3689.2,1399.45,1);
					spawnPlat(4627.1,-164.85,3);
					spawnPlat(3878.25,1294.9,4);
				break;
				case 1:
					
				break;
			}
		}
		
		private function lvlDestruct():void {
			for (var s:int;s<colArray.length;s++){
				removeChild(colArray[s]);
				
			}
			for (var w:int;w<pArray.length;w++) {
				removeChild(pArray[w]);
				
			}
			colArray = [];
			pArray = [];
		}
		
		private function setupPly():void {
			ply.y = 300;
			ply.x = 300;
			addChild(ply);
		}
		 
		 
		private function spawnDoor():void {
			
		}
		
		private var jumping:Boolean = false;
		private var canLeft:Boolean = true;
		private var canRight:Boolean = true;
		private var canJump:Boolean = true;
		private var yesFly:Boolean = false;
		
		private function keyPress(k:KeyboardEvent):void {
			if (k.keyCode == Keyboard.SPACE && /*getTile(ply.x,ply.y+2) == 1 &&*/ sideScroll == true) {
				ply.jumpStart(25);
				if (fly == true && ply.isJumping == true) {
					yesFly = true;
					ply.isJumping == true;
				} else {
					ply.checkDJump(20);
				}
				//jUp = true;
				jumping = true;
			}
			if (k.keyCode == Keyboard.A && canLeft == true) {
				left = true;
			}
			if (k.keyCode == Keyboard.D && canRight == true) {
				right = true;
			}
			if (k.keyCode == Keyboard.W && sideScroll == false) {
				up = true;
			}
			if (k.keyCode == Keyboard.S && sideScroll == false) {
				down = true;
			} else if (k.keyCode == Keyboard.S) {
				drop = true;
			}
		}
		
		private function keyRelease(k:KeyboardEvent):void {
			if (k.keyCode == Keyboard.SPACE) {
				ply.jumpStop();
				yesFly = false;
				jumping = false;
			}
			
			if (k.keyCode == Keyboard.A) {
				left = false;
				tLeft = false;
				ply.stopPly();
			}
			
			if (k.keyCode == Keyboard.D) {
				right = false;
				tRight = false;
				ply.stopPly();
			}
			
			if (k.keyCode == Keyboard.W) {
				up = false;
				tUp = false;
				ply.stopPly();
			}
			
			if (k.keyCode == Keyboard.S) {
				down = false;
				tDown = false;
				drop = false;
				ply.stopPly();
			}
		}

		
		
		private var topDown:Boolean = false;
		private var sideScroll:Boolean = true;
		
		private var dly:uint = 2000;
		private var rpt:uint = 5;
		private var timeC:Timer = new Timer(dly,rpt);
		
		private var removeRenders:Boolean = false;
		
		private var doorList:Array = new Array();
		
		private var tLeft:Boolean = false;
		private var tRight:Boolean = false;
		private var tUp:Boolean = false;
		private var tDown:Boolean = false;
		
		private var colArray:Array = new Array();
		private var pArray:Array = new Array();
		
		public function getTile(xs,ys){
			if(ys>0 && xs>0 && (colTArray[0].length)*40>xs && (colTArray.length)*40>ys){
				return colTArray[Math.floor(ys/40)][Math.floor(xs/40)]
			} else {
				return (0);
			}
		}
		
		private function spawnPlat(xP:Number,yP:Number,tP:Number):void {
				switch (tP) {
					case 0:
						var platS:PlatformS = new PlatformS();
						platS.x = xP;
						platS.y = yP;
						colArray.push(platS);
						addChild(platS);
					break;
					case 1:
						var platM:PlatformM = new PlatformM();
						platM.x = xP;
						platM.y = yP;
						colArray.push(platM);
						addChild(platM);
					break;
					case 2:
						var platL:PlatformL = new PlatformL();
						platL.x = xP;
						platL.y = yP;
						colArray.push(platL);
						addChild(platL);
					break;
					case 3:
						var dor:Door = new Door();
						dor.x = xP;
						dor.y = yP;
						pArray.push(dor);
						addChild(dor);
					break;
					case 4:
						var jPck:JPack = new JPack();
						jPck.x = xP;
						jPck.y = yP;
						pArray.push(jPck);
						addChild(jPck);
					break;
						
			}
		}
		
		private var gndDebug:Boolean = false;
		private var testInt:Number;
		private var fly:Boolean = false;
		
		private var platL:Boolean = false;
		private var platR:Boolean = false;
		private var platD:Boolean = false;
		private var platU:Boolean = false;
		
		private var someInt:int;
		
		private var mSpeedX:Number = 6;
		
		private function globalLoop(e:Event):void {
			
			
			
			if (sideScroll == true) {
				
				if (yesFly == true && fuel.checkV() == false) {
					ply.checkFly(1.5);
					fuel.updateA(0.002);
				}
				
				if (ply.x <= 140) {
					ply.x = 141;
					platL = true;
				} else {
					platL = false;
				}
				
				if (ply.x >= 850) {
					ply.x = 849;
					platR = true;
				} else {
					platR = false;
				}
				
				if (ply.y < 50) {
					ply.y = 50
					platU = true;
				} else {
					platU = false;
				}
				
				if (ply.y > 650) {
					ply.y = 645;
					platD = true;
					trace("up");
				} else {
					platD = false;
					trace("down");
				}
			
				if (jUp == true) {
					if (ply.gravSpeed > ply.gravMax) {
						ply.gravSpeed = ply.gravMax;
					} else {
						ply.gravSpeed += ply.gravAcc;
					}
					ply.y += ply.gravSpeed;
				}
				
				if (left == true) {
					ply.left(mSpeedX);
				}
				
				if (right == true) {
					ply.right(mSpeedX);
				}
				
				for (var h:int;h<colArray.length;h++){
					colS(ply,colArray[h])
					
					if (platL == true) {
						colArray[h].x += mSpeedX;
					}
					
					if (platR == true) {
						colArray[h].x -= mSpeedX;
					}
					
					if (platU == true) {
						colArray[h].y -= ply.gravSpeed;
					}
					
					if (platD == true) {
						colArray[h].y -= ply.gravSpeed;
					}
				}
				
				for (var f:int;f<pArray.length;f++) {
					if (platL == true) {
						pArray[f].x += mSpeedX;
					}
					
					if (platR == true) {
						pArray[f].x -= mSpeedX;
					}
					
					if (platU == true) {
						pArray[f].y -= ply.gravSpeed;
					}
					
					if (platD == true) {
						pArray[f].y -= ply.gravSpeed;
					}
				}
				
				/*for (var i:int;i<doorList.length;i++) {
					if (removeRenders == true) {
						removeChild(doorList[i]);
						doorList.removeAt(i);
						trace (doorList);
						if (doorList.length <= 0) {
							removeRenders == false;
						}
					}
				}*/
				for (var p:int;p<pArray.length;p++) {
					if (ply.hitTestObject(pArray[p])) {
						switch (pArray[p].checkID()) {
							case 0:
								gotoAndStop(2);
								topDown = true;
								sideScroll = false;
								addChild(map);
								setChildIndex(map,0);
								lvlDestruct();
							break;
							case 1:
								removeChild(pArray[p]);
								pArray.removeAt(p);
								fly = true;
							break;	
						}
					}
				}
				
			} else if (topDown == true) {
				
				for (var k:int;k<pArray.length;k++) {
					
					if (tLeft == true) {
						pArray[k].x += 7;
					}
					
					if (tRight == true) {
						pArray[k].x -= 7;
					}
					
					if (tUp == true) {
						pArray[k].y += 7;
					}
					
					if (tDown == true) {
						pArray[k].y -= 7;
					}
				}
				
				if (left == true) {
					if (ply.x >= 120) {
						ply.left(7);
					} else {
						map.x += 7;
						ply.left(0);
						tLeft = true;
					}
				}
				if (right == true) {
					if (ply.x <= 1180) {
						ply.right(7);
					} else {
						map.x -= 7;
						ply.right(0);
						tRight = true;
					}
				}
				if (up == true) {
					if (ply.y >= 100) {
						ply.up(7);
					} else {
						map.y += 7;
						ply.up(0);
						tUp = true;
					}
				}
				if (down == true) {
					if (ply.y <= 640) {
						ply.down(7);
					} else {
						map.y -= 7
						ply.down(0);
						tDown = true;
					}
				}
			}
			ply.x += ply.curSpeedX;
			ply.y += ply.curSpeedY;
		}
		
		private var bHit:Boolean = false;
		
		private function colS(colDefP:Object, colDefO:Object): void {
			if (colDefO.hitTestObject(colDefP)) {
				if (colDefP.x - colDefP.width / 2 <= colDefO.x + colDefO.width && colDefP.x + colDefP.width / 2 >= colDefO.x + colDefO.width && colDefP.curSpeedX < 0) {
					colDefP.curSpeedX = 0;
					left = false;
					//colDefP.x = colDefO.x + colDefO.width + 1 + colDefP.width / 2;	
				} else if (colDefP.x + colDefP.width / 2 >= colDefO.x && colDefP.x - colDefP.width / 2 <= colDefO.x && colDefP.curSpeedX > 0) {
					//colDefP.x = colDefO.x - 1 - colDefP.width / 2;
					colDefP.curSpeedX = 0;
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
				//Local Handling
				colDefP.isJumping = false;
				colDefP.dJump = false;
			}
		}
	}	
}
