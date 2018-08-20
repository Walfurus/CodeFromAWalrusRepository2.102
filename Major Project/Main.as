
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
		
		private var tileSet:Array = [[[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]],
									 
									 [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,2,2,2,2,2,2,0,0,0,0,0,0,0,0,2,2,2,2,2,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									  [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1],
									  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]],
									  
									 [[0,0],
									  [0,0]]];
		
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
			}
		}
		
		private function lvlDestruct():void {
			gndArray.length = 0;
			removeChild(tiles);
			tiles = new MovieClip();
			//colTArray.length = 0;
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
		
		private function keyPress(k:KeyboardEvent):void {
			if (k.keyCode == Keyboard.SPACE && /*getTile(ply.x,ply.y+2) == 1 &&*/ sideScroll == true) {
				ply.jumpStart(20);
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
		
		function endTime(e:TimerEvent):void {
			var door:DebugDoor = new DebugDoor();
			doorList.push(door);
			door.x = ply.x + util.randNum(-500,500);
			if (ply.x == Math.abs(door.x)) {
				door.x = ply.x + util.randNum(-500,500);
			}
			door.y = ply.y + util.randNum(-400,400);
			if (ply.y == Math.abs(door.y)) {
				door.y = ply.y + util.randNum(-400,400);
			}
			addChild(door);
			dly = util.randNum(1000,3000);
			trace(dly);
		}
		
		private var gndArray:Array = new Array();
		public var tiles:MovieClip = new MovieClip();
		
		private function lConstruct(layout:Array) {
			for (var q:int=0;q<layout[0].length;q++) {
				for (var s:int=0;s<layout.length;s++) {
					var curTile:Tile = new Tile();
					curTile.x = q*40;
					curTile.y = s*40;
					curTile.name = q+"-"+s;
					tiles.addChild(curTile);
					gndArray.push(curTile);
					curTile.gotoAndStop(int(layout[s][q])+1);
					trace ("bulding");
				}
			}
				addChild(tiles);
		}
		
		//private var gameLay:Array = new Array();
		

		private var colArray:Array = new Array();
		private var dorArray:Array = new Array();
		
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
						dorArray.push(dor);
						addChild(dor);
					break;
			}
		}
		
		private var gndDebug:Boolean = false;
		private var testInt:Number;
		
		private function globalLoop(e:Event):void {
			
			trace(jumping);
			
			if (sideScroll == true) {
				
				if (ply.x <= 70) {
					ply.x = 71;
				}
				
				if (ply.x >= 1209) {
					ply.x = 1209;
				}
				
				
				
				//if ((getTile(ply.x,ply.y) == 1 || getTile(ply.x-29,ply.y) == 1 || getTile(ply.x+29,ply.y) == 1) || (getTile(ply.x,ply.y) == 2 || getTile(ply.x-29,ply.y) == 2 || getTile(ply.x+29,ply.y) == 2) || (getTile(ply.x,ply.y) == 3 || getTile(ply.x-29,ply.y) == 3 || getTile(ply.x+29,ply.y) == 3) || (getTile(ply.x,ply.y) == 4 || getTile(ply.x-29,ply.y) == 4 || getTile(ply.x+29,ply.y+1) == 4) || (getTile(ply.x,ply.y) == 5 || getTile(ply.x-29,ply.y) == 5 || getTile(ply.x+29,ply.y) == 5) || (getTile(ply.x,ply.y) == 6 || getTile(ply.x-29,ply.y) == 6 || getTile(ply.x+29,ply.y) == 6)){
				//	//ply.y -= 1;
				//	//jUp = false;
				//	//for (var ss:int=0;ss<gndArray.length;ss++) {
				//		//if (ply.hitTestObject(gndArray[ss])){
				//			jUp == false;
				//			if ((getTile(ply.x,ply.y) == 1 || getTile(ply.x-29,ply.y) == 1 || getTile(ply.x+29,ply.y) == 1)) {
				//				if (jumping != true) {
				//					ply.y -= ply.gravSpeed;
				//				}

				//			} else if ((getTile(ply.x,ply.y) == 2 || getTile(ply.x-29,ply.y) == 2 || getTile(ply.x+29,ply.y) == 2) && drop == false) {
				//				if (jumping != true){
				//					ply.y -= ply.gravSpeed;
				//				}
				//				//ply.y -= ply.gravSpeed;
				//				
				//				//trace ("hiya");
				//			} else if ((getTile(ply.x,ply.y) == 2 || getTile(ply.x-29,ply.y) == 2 || getTile(ply.x+29,ply.y) == 2) && drop == true) {
				//				jUp = true;
				//			}
				//		//} 
				//		
				//		if (jumping == false) {
				//			if ((getTile(ply.x,ply.y+1) == 2 || getTile(ply.x-29,ply.y+1) == 2 || getTile(ply.x+29,ply.y+1) == 2) && drop == true){
				//				jUp = true;
				//			} else {
				//				jUp = false;
				//				ply.gravSpeed = 0;
				//			}
				//		} else {
				//			jUp = true;
				//		}
				//			
				//		if (ply.gravSpeed >= 0 && drop == false) {
				//			jUp = false;
				//		}
				//	//}
				//}
				//	
				//if (getTile(ply.x, ply.y) == 0){
				//	jUp = true; 
				//}
				//	
				//	
				//	//trace (getTile(ply.x,ply.y));
				//	//trace (gndArray.length);
				//
				//if ((getTile(ply.x-31,ply.y-2) == 1 || getTile(ply.x-31,ply.y-23) == 1) && left == true) {
				//	//for (var vv:int=0;vv<gndArray.length;vv++) {
				//		//if (gndArray[vv].hitTestObject(ply)) {
				//			//ply.x = (gndArray[vv].x + 75);
				//			ply.x += 5;
				//			ply.curSpeedX = 0;
				//			//canLeft = false;
				//			//trace ("hi")
				//		//}
				//	}
				// //else {
				//		//canLeft = true;
				//	//}
				//
				//if ((getTile(ply.x+31,ply.y-2) == 1 || getTile(ply.x+31,ply.y-23) == 1) && right == true){
				//	//for (var qq:int=0;qq<gndArray.length;qq++) {
				//		//if (gndArray[qq].hitTestObject(ply)){
				//			//ply.x = (gndArray[qq].x - 35);
				//			ply.x -= 5;
				//			ply.curSpeedX = 0;
				//			//canRight = false;
				//			//trace ("hi")
				//		//}
				//	//}
				//} //else {
				//		//canRight = true;
				//	//}
				//
				//if (getTile(ply.x,ply.y-52) == 1 || getTile(ply.x-29,ply.y-52) == 1 || getTile(ply.x+29,ply.y-52) == 1){
				//	ply.y += 3;
				//	ply.gravSpeed = 0;
				//}
			
				if (jUp == true) {
					if (ply.gravSpeed > ply.gravMax) {
						ply.gravSpeed = ply.gravMax;
					} else {
						ply.gravSpeed += ply.gravAcc;
					}
					ply.y += ply.gravSpeed;
				}
				
				if (left == true) {
					ply.left(5);
				}
				
				if (right == true) {
					ply.right(5);
				}
				
				for (var h:int;h<colArray.length;h++){
					colS(ply,colArray[h])
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
				
				if (ply.hitTestObject(dorArray[0])) {
					gotoAndStop(2);
					topDown = true;
					sideScroll = false;
					
					addChild(map);
					setChildIndex(map,0);
					dly = util.randNum(5000,15000);
					
					if (doorList.length < 1) {
						timeC.start();
						timeC.addEventListener(TimerEvent.TIMER, endTime);
					}
				}
				
			} else if (topDown == true) {
				
				for (var k:int;k<doorList.length;k++) {
					if (ply.hitTestObject(doorList[k])) {
						gotoAndStop(1);
						//lvlConstruct(0);
						topDown = false;
						sideScroll = true;
						removeChild(map);
						//doorList[i].x = 50000;
						removeRenders = true;
						timeC.reset();
						timeC.stop();
					}
					
					if (tLeft == true) {
						doorList[k].left(7);
					}
					
					if (tRight == true) {
						doorList[k].right(7);
					}
					
					if (tUp == true) {
						doorList[k].up(7);
					}
					
					if (tDown == true) {
						doorList[k].down(7);
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
		
		private function colS(colDefP:Object, colDefO:Object): void {
			if (colDefO.hitTestObject(colDefP)) {
				if (colDefP.x - colDefP.width / 2 <= colDefO.x + colDefO.width && colDefP.x + colDefP.width / 2 >= colDefO.x + colDefO.width && colDefP.curSpeedX < 0) {
					colDefP.x = colDefO.x + colDefO.width + 1 + colDefP.width / 2;
					colDefP.curSpeedX = 0;
					left = false;
				} else if (colDefP.x + colDefP.width / 2 >= colDefO.x && colDefP.x - colDefP.width / 2 <= colDefO.x && colDefP.curSpeedX > 0) {
					colDefP.x = colDefO.x - 1 - colDefP.width / 2;
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
			}
		}
	}	
}
