
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
		private var aMp:ActMap = new ActMap();
		
		private var uiS:UIScreen = new UIScreen();
		private var uiB:UIButton = new UIButton();
		
		private var colTArray:Array = new Array();
		private var lvlSelect:uint = 1;
		
		public function Main() {
			//forwards.addEventListener(MouseEvent.CLICK, fwdCom);
			//execute.addEventListener(MouseEvent.CLICK, runCommands);
			
			stop();
			util = new Utilities();
			start.addEventListener(MouseEvent.CLICK, startGame);
			help.addEventListener(MouseEvent.CLICK, helpGame);
			
		}
		
		private var gameStart:Boolean = false;
		
		private function initial():void {
			lvlConstruct(0);
			uiConstruct();
			jUp = true;
			fuel.x = 40;
			fuel.y = 30;
			fuel.alpha = 0.0;
			addChild(fuel);
		}
		
		private function uiConstruct():void {
			uiS.x = 8;
			uiS.y = 505;
			uiB.x = 609;
			uiB.y = 505;
			uiB.addEventListener(MouseEvent.CLICK, uiClick)
			uiS.gotoAndStop(60);
		}
		
		private function uiClick (e:MouseEvent):void {
			trace("hi");
			if (uiB.currentFrame == 1) {
				uiB.gotoAndPlay(1);
				uiS.gotoAndPlay(1);
			} else {
				uiB.gotoAndPlay(35);
				uiS.gotoAndPlay(35);
			}
		}
		
		private function startGame(e:MouseEvent) {
			gotoAndStop(6);
			gameStart = true;
			stage.addEventListener(Event.ENTER_FRAME, globalLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
			setupPly();
			initial();
		}
		
		private function helpGame(e:MouseEvent) {
			gotoAndStop(15);
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
					spawnPlat(-54.25,-322.55,5);
					addChild(ply);
					addChild(uiS);
					addChild(uiB);
				break;
				case 1:
					spawnPlat(113.55,557.5,2);
					spawnPlat(668.2,364.5,0);
					spawnPlat(480.2,155.55,0);
					spawnPlat(890.5,19.5,1);
					spawnPlat(1421.4,190.55,1);
					spawnPlat(1924.4,62.55,1);
					spawnPlat(2486.95,120.55,0);
					spawnPlat(2764,72.55,0);
					spawnPlat(3179.25,19.5,2);
					spawnPlat(3566.3,-247.45,1);
					spawnPlat(3786.3,-470.45,1);
					spawnPlat(4054.9,97.55,0);
					spawnPlat(4414.2,-15.5,2);
					spawnPlat(1094.4,746.45,2);
					spawnPlat(1840.35,608.5,1);
					spawnPlat(2336.3,821.45,1);
					spawnPlat(2849.3,957.45,2);
					spawnPlat(5078.6,-162.15,0);
					spawnPlat(5338.8,-308.75,1);
					spawnPlat(5721.45,-482.8,2);
					spawnPlat(-54.25,-322.55,5);
					spawnPlat(513.95,408.35,10);
					spawnPlat(696.8,-57.25,10);
					spawnPlat(1357.3,-99,10);
					spawnPlat(1965.85,-147.75,10);
					spawnPlat(2115.35,-147.75,10);
					spawnPlat(3383.4,-140.75,10);
					spawnPlat(3684.2,-383.8,10);
					spawnPlat(3946.75,-106,10);
					spawnPlat(908.65,225.55,8);
					spawnPlat(1094.4,348.45,8);
					spawnPlat(1189.95,539.7,8);
					spawnPlat(1714.5,477.4,8);
					spawnPlat(2336.3,471.15,8);
					spawnPlat(2774.25,643.5,8);
					spawnPlat(4514.7,-242.55,8);
					spawnPlat(4766.5,-242.55,8);
					spawnPlat(5151.6,-488.1,8);
					spawnPlat(5552.35,-660.2,8);
					spawnPlat(5990.05,-672.25,9);
					spawnPlat(6068.3,-841.8,9);
					spawnPlat(6148.95,-722.3,9);
					spawnPlat(3264.75,839.45,6);
					spawnPlat(3990.25,-632.2,3);
					addChild(ply);
					addChild(uiS);
					addChild(uiB);
				break;
				case 2:
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
			for (var t:int;t<vArray.length;t++) {
				removeChild(vArray[t]);
			}
			removeChild(bArray[0]);
			colArray = [];
			vArray = [];
			pArray = [];
			bArray = [];
		}
		
		private function setupPly():void {
			ply.y = 300;
			ply.x = 300;
			ply.gotoAndStop(1);
			addChild(ply);
		}
		 
		 
		private function mpDestruct():void {
			removeChild(map);
			removeChild(wall);
			removeChild(aMp);
		}
		
		private var jumping:Boolean = false;
		private var canLeft:Boolean = true;
		private var canRight:Boolean = true;
		private var canJump:Boolean = true;
		private var yesFly:Boolean = false;
		
		private function keyPress(k:KeyboardEvent):void {
			if (gameStart == true) {
				if (k.keyCode == Keyboard.SPACE && sideScroll == true) {
					ply.jumpStart(25);
					if (fly == true && ply.isJumping == true && fuel.scaleX > 0) {
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
					if (sideScroll == true && left == true && right == true) {
						ply.gotoAndStop(3);
					} else if (sideScroll == true) {
						ply.gotoAndStop(4);
					} else if (topDown == true && up == false && down == false) {
						ply.gotoAndStop(8);
					}
				}
				if (k.keyCode == Keyboard.D && canRight == true) {
					right = true;
					if (sideScroll == true) {
						ply.gotoAndStop(3);
					} else if (topDown == true && up == false && down == false) {
						ply.gotoAndStop(6)
					}
				}
				if (k.keyCode == Keyboard.W && right == true && sideScroll == false) {
					up = true;
					ply.gotoAndStop (10);
				} else if (k.keyCode == Keyboard.W && left == true && sideScroll == false) {
					up = true;
					ply.gotoAndStop(9);
				} else if (k.keyCode == Keyboard.W && sideScroll == false) {
					up = true;
					ply.gotoAndStop(5);
				}
				
				if (k.keyCode == Keyboard.S && right == true && sideScroll == false) {
					down = true;
					ply.gotoAndStop (11);
				} else if (k.keyCode == Keyboard.S && left == true && sideScroll == false) {
					down = true;
					ply.gotoAndStop (12);
				} else if (k.keyCode == Keyboard.S && sideScroll == false){
					down = true;
					ply.gotoAndStop(7);
				}
				
				if (k.keyCode == Keyboard.F && topDown == true) {
					if (aMp.lvl1.hitTestObject(ply)) {
						mpDestruct();
						lvlConstruct(1);
						topDown = false;
						sideScroll = true;
					}
					if (aMp.lvl2.hitTestObject(ply)) {
						mpDestruct();
						lvlConstruct(2);
						topDown = false;
						sideScroll = true;
					}
					if (aMp.lvl3.hitTestObject(ply)) {
						mpDestruct();
						lvlConstruct(3);
						topDown = false;
						sideScroll = true;
					}
					if (aMp.lvl4.hitTestObject(ply)) {
						mpDestruct();
						lvlConstruct(4);
						topDown = false;
						sideScroll = true;
					}
					if (aMp.dragStart.hitTestObject(ply)) {
						topDown = false;
						dragDrop = true;
						gotoAndStop(5);
						addEventListener(Event.ENTER_FRAME, mvObj);
						mpDestruct();
					}
				}
			}
		}
		
		private function keyRelease(k:KeyboardEvent):void {
			if (gameStart == true) {
				if (k.keyCode == Keyboard.SPACE) {
					ply.jumpStop();
					yesFly = false;
					jumping = false;
				}
				
				if (k.keyCode == Keyboard.A) {
					left = false;
					tLeft = false;
					ply.stopPly();
					if (right == true && sideScroll == true) {
						ply.gotoAndStop(3);
					} else if (sideScroll == true) {
						ply.gotoAndStop(2);
					}
				}
				
				if (k.keyCode == Keyboard.D) {
					right = false;
					tRight = false;
					ply.stopPly();
					if (left == true && sideScroll == true) {
						ply.gotoAndStop(4);
					} else if (sideScroll == true) {
						ply.gotoAndStop(1)
					}
					
				}
				
				if (k.keyCode == Keyboard.W) {
					up = false;
					tUp = false;
					ply.stopPly();
					
					if (right == true) {
						ply.gotoAndStop(10);
					} else if (left == true) {
						ply.gotoAndStop(9);
					} else {
						ply.gotoAndStop(5);
					}
				}
				
				if (k.keyCode == Keyboard.S) {
					down = false;
					tDown = false;
					ply.stopPly();
					if (right == true) {
						ply.gotoAndStop(11);
					} else if (left == true) {
						ply.gotoAndStop(12);
					} else {
						ply.gotoAndStop(7);
					}
				}
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
		private var vArray:Array = new Array();
		private var bArray:Array = new Array();
		
		private function spawnPlat(xP:Number,yP:Number,tP:Number):void {
			switch (tP) {
				case 0:
					var platS:PlatformS = new PlatformS();
					var pMskS:PMaskS = new PMaskS();
					platS.x = xP;
					platS.y = yP;
					platS.alpha = 0.01;
					pMskS.x = xP;
					pMskS.y = yP;
					colArray.push(platS);
					vArray.push(pMskS);
					addChildAt(platS,1);
					addChildAt(pMskS,2);
				break;
				case 1:
					var platM:PlatformM = new PlatformM();
					var pMskM:PMaskM = new PMaskM();
					platM.x = xP;
					platM.y = yP;
					platM.alpha = 0.01;
					pMskM.x = xP;
					pMskM.y = yP;
					colArray.push(platM);
					vArray.push(pMskM);
					addChildAt(platM,1);
					addChildAt(pMskM,2);
				break;
				case 2:
					var platL:PlatformL = new PlatformL();
					var pMskL:PMaskL = new PMaskL();
					platL.x = xP;
					platL.y = yP;
					platL.alpha = 0.01;
					pMskL.x = xP;
					pMskL.y = yP;
					colArray.push(platL);
					vArray.push(pMskL);
					addChildAt(platL,1);
					addChildAt(pMskL,2);
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
				case 5:
					var bckg:Background = new Background();
					bckg.x = xP;
					bckg.y = yP;
					bArray.push(bckg);
					addChildAt(bckg,0);
				break;
				case 6:
					var mag:Magnesium = new Magnesium();
					mag.x = xP;
					mag.y = yP;
					pArray.push(mag);
					addChild(mag);
				break;
				case 7:
					var qtz:Quartz = new Quartz();
					qtz.x = xP;
					qtz.y = yP;
					pArray.push(qtz);
					addChild(qtz);
				break;
				case 8:
					var led:Lead = new Lead();
					led.x = xP;
					led.y = yP;
					pArray.push(led);
					addChild(led);
				break;
				case 9: 
					var irn:Iron = new Iron();
					irn.x = xP;
					irn.y = yP;
					pArray.push(irn);
					addChild(irn);
				break;
				case 10:
					var sil:Silicon = new Silicon();
					sil.x = xP;
					sil.y = yP;
					pArray.push(sil);
					addChild(sil);
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
		
		private var wall:Wall = new Wall();
		
		private var someInt:Number;
		
		private var mSpeedX:Number = 6;
		private var dragDrop:Boolean = false;
		
		private var fuel:Fuel = new Fuel();
		
		private function globalLoop(e:Event):void {
			
			if (uiS.uiContent.currentFrame == 1) {
				uiS.uiContent.silShow.text = silNum.toString();
				uiS.uiContent.ledShow.text = ledNum.toString();
				uiS.uiContent.irnShow.text = irnNum.toString();
				uiS.uiContent.qtzShow.text = qtzNum.toString();
				uiS.uiContent.magShow.text = magNum.toString();
			}
			
			if (sideScroll == true) {
				
				if (yesFly == true && fuel.checkV() == false) {
					ply.checkFly(1.5);
					fuel.updateA(0.002);
				} else if (fuel.checkV() == true) {
					fly = false;
				}
				
				if (ply.x <= 200 && bArray[0].x >= 0) {
					//platL = false;
				} else if (ply.x <= 200 && bArray[0].x <= 0) {
					ply.x = 201;
					platL = true;
				} else {
					platL = false;
				}
				
				if (ply.x >= 850 && bArray[0].x <= -3840) {
					//platR = false;
				} else if (ply.x >= 850 && bArray[0].x >= -3840) {
					ply.x = 849;
					platR = true;
				} else {
					platR = false;
				}
				
				if (ply.y < 50 && bArray[0].y >= 0) {
					//platU = false;
				} else if (ply.y < 50 && bArray[0].y <= 0) {
					ply.y = 55
					platU = true;
				} else {
					platU = false;
				}
				
				if (ply.y > 650 && bArray[0].y <= -560) {
					//platD = false;
				} else if (ply.y > 650 && bArray[0].y >= -560) {
					ply.y = 645;
					platD = true;
				} else {
					platD = false;
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
					colS(ply,colArray[h]);
					
					if (platL == true) {
						if (bArray[0].x >= 0) {
							
						} else {
							bArray[0].x += 0.2;
							colArray[h].x += mSpeedX;
							vArray[h].x += mSpeedX;
						}						
					}
					
					if (platR == true) {
						if (bArray[0].x <= -3840) {
							
						} else {
							bArray[0].x -= 0.2;
							colArray[h].x -= mSpeedX;
							vArray[h].x -= mSpeedX;
						}
					}
					
					if (platU == true && ply.gravSpeed != 1) {
						colArray[h].y -= ply.gravSpeed;
						vArray[h].y -= ply.gravSpeed;
						
						if (bArray[0].y >= 0) {
							
						} else {
							bArray[0].y -= 0.005*ply.gravSpeed;
						}
					}
					
					if (platD == true && ply.gravSpeed != 1) {
						colArray[h].y -= ply.gravSpeed;
						vArray[h].y -= ply.gravSpeed;
						if (bArray[0].y <= -560){
							
						} else {
							bArray[0].y -= 0.005*ply.gravSpeed;
						}
					}
				}
				
				for (var f:int;f<pArray.length;f++) {
					if (platL == true) {
						pArray[f].x += mSpeedX;
					}
					
					if (platR == true) {
						pArray[f].x -= mSpeedX;
					}
					
					if (platU == true && ply.gravSpeed != 1) {
						pArray[f].y -= ply.gravSpeed;
					}
					
					if (platD == true && ply.gravSpeed != 1) {
						pArray[f].y -= ply.gravSpeed;
					}
				}
				
				for (var p:int;p<pArray.length;p++) {
					if (ply.hitTestObject(pArray[p])) {
						switch (pArray[p].checkID()) {
							case 0:
								gotoAndStop(6);
								ply.gotoAndStop(5);
								topDown = true;
								sideScroll = false;
								addChild(map);
								map.x = -2331.15;
								map.y = -2540.65;
								addChildAt(wall,0);
								wall.x = -2331.15;
								wall.y = -2540.65;
								addChildAt(aMp,1);
								aMp.x = -2331.15;
								aMp.y = -2540.65;
								setChildIndex(map,2);
								lvlDestruct();
							break;
							case 1:
								removeChild(pArray[p]);
								fuel.resetF();
								pArray.removeAt(p);
								fly = true;
							break;
							case 2:
								gotoAndStop(15);
								addEventListener(Event.ENTER_FRAME, mvObj)
								topDown = false;
								sideScroll = false;
								dragDrop = true;
								lvlDestruct();
							break;
							case 3:
								removeChild(pArray[p]);
								pArray.removeAt(p);
								magNum++;
							break;
							case 4:
								removeChild(pArray[p]);
								pArray.removeAt(p);
								qtzNum++;
							break;
							case 5:
								removeChild(pArray[p]);
								pArray.removeAt(p);
								ledNum++;
							break;
							case 6:
								removeChild(pArray[p]);
								pArray.removeAt(p);
								irnNum++;
							break;
							case 7:
								removeChild(pArray[p]);
								pArray.removeAt(p);
								silNum++;
							break;
						}
						
						if (ply.y >= 1000) {
							
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
					if (!wall.hitTestPoint(ply.x-21,ply.y-23,true)) {
						if (ply.x >= 120) {
							ply.left(7);
						} else {
							map.x += 7;
							wall.x += 7;
							aMp.x += 7;
							ply.left(0);
							tLeft = true;
						}
					} else {
						ply.x += 7;
					}
				}
				
				if (right == true) {
					if (!wall.hitTestPoint(ply.x+21,ply.y-23,true)) {
						if (ply.x <= 1180) {
							ply.right(7);
						} else {
							map.x -= 7;
							wall.x -= 7;
							aMp.x -= 7;
							ply.right(0);
							tRight = true;
						}
					} else {
						ply.x -= 7;
					}
				}
				
				if (up == true) {
					if (!wall.hitTestPoint(ply.x,ply.y-46,true)) {
						if (ply.y >= 100) {
							ply.up(7);
						} else {
							map.y += 7;
							wall.y += 7;
							aMp.y += 7;
							ply.up(0);
							tUp = true;
						}
					} else {
						ply.y += 7;
					}
				}
				
				if (down == true) {
					if (!wall.hitTestPoint(ply.x,ply.y,true)) {
						if (ply.y <= 640) {
							ply.down(7);
						} else {
							map.y -= 7;
							wall.y -= 7;
							aMp.y -= 7;
							ply.down(0);
							tDown = true;
						}
					} else {
						ply.y -= 7;
					}
				}
				
			} else if (dragDrop == true) {
				while (spNum <= maxSp) {
					spNum++;
					addSp();
					//curSps++;
				}
				
				if (spnLoc <= -400) {
					spnLoc = - 40
				}
				trace(getChildIndex(mins[0]));
				//trace(mins[0].x);
			}
			ply.x += ply.curSpeedX;
			ply.y += ply.curSpeedY;
		}
		
		private var irnNum:int = 0;
		private var ledNum:int = 0;
		private var silNum:int = 0;
		private var qtzNum:int = 0;
		private var magNum:int = 0;
		private var rndSpNum:int;
		
		private var spTot:Number = 0;
		private var spnLoc:Number = -40;
		private var spNum:Number = 0;
		private var maxSp:Number = 10;
		private var curSps:Number = 0;
		
		private var plyScore:Number = 0;
		
		private function addSp():void {
			rndSpNum = util.randNum(0,4);
			//spNum++;
			spnLoc = spnLoc - 20;
			trace("hi");
			
			var irn:dIron = new dIron();
			var led:dLead = new dLead();
			var sil:dSilicon = new dSilicon();
			var qtz:dQuartz = new dQuartz();
			var mag:dMagnesium = new dMagnesium();
			var deb:dDebris = new dDebris();
			
			switch (rndSpNum) {
				case 0:
					if (irnNum > 0) {
						addChild(irn);
						irnNum--;
						spTot++;
						irn.x = util.randNum(805,1010);
						irn.y = spnLoc;
						mins.push(irn);
						irn.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
						irn.addEventListener(MouseEvent.MOUSE_UP, mUp);
						irn.addEventListener(Event.ENTER_FRAME, mRSpn);
					} else {
						addChild(deb);
						deb.x = util.randNum(805,1010);
						deb.y = spnLoc;
						mins.push(deb);
						deb.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
						deb.addEventListener(MouseEvent.MOUSE_UP, mUp);
						deb.addEventListener(Event.ENTER_FRAME, mRSpn);
					}
				break;
				case 1:
					if (ledNum > 0) {
						addChild(led);
						ledNum--;
						spTot++;
						led.x = util.randNum(805,1010);
						led.y = spnLoc;
						mins.push(led);
						led.addEventListener(MouseEvent.MOUSE_DOWN, mDown);		//Mouse event handlers, up then down, the names of the functions however does not need to differ
						led.addEventListener(MouseEvent.MOUSE_UP, mUp);
						led.addEventListener(Event.ENTER_FRAME, mRSpn);
					} else {
						addChild(deb);
						deb.x = util.randNum(805,1010);
						deb.y = spnLoc;
						mins.push(deb);
						deb.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
						deb.addEventListener(MouseEvent.MOUSE_UP, mUp);
						deb.addEventListener(Event.ENTER_FRAME, mRSpn);
					}
				break;
				case 2:
					if (silNum > 0) {
						addChild(irn);
						silNum--;
						spTot++;
						sil.x = util.randNum(805,1010);
						sil.y = spnLoc;
						mins.push(sil);
						sil.addEventListener(MouseEvent.MOUSE_DOWN, mDown);		//Mouse event handlers, up then down, the names of the functions however does not need to differ
						sil.addEventListener(MouseEvent.MOUSE_UP, mUp);
						sil.addEventListener(Event.ENTER_FRAME, mRSpn);
					} else {
						addChild(deb);
						deb.x = util.randNum(805,1010);
						deb.y = spnLoc;
						mins.push(deb);
						deb.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
						deb.addEventListener(MouseEvent.MOUSE_UP, mUp);
						deb.addEventListener(Event.ENTER_FRAME, mRSpn);
					}
				break;
				case 3:
					if (qtzNum > 0) {
						addChild(qtz);
						spTot++;
						qtzNum--;
						qtz.x = util.randNum(805,1010);
						qtz.y = spnLoc;
						mins.push(qtz);
						qtz.addEventListener(MouseEvent.MOUSE_DOWN, mDown);		//Mouse event handlers, up then down, the names of the functions however does not need to differ
						qtz.addEventListener(MouseEvent.MOUSE_UP, mUp);
						qtz.addEventListener(Event.ENTER_FRAME, mRSpn);
					} else {
						addChild(deb);
						deb.x = util.randNum(805,1010);
						deb.y = spnLoc;
						mins.push(deb);
						deb.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
						deb.addEventListener(MouseEvent.MOUSE_UP, mUp);
						deb.addEventListener(Event.ENTER_FRAME, mRSpn);
					}
				break;
				case 4:
					if (magNum > 0) {
						addChild(mag);
						spTot++;
						magNum--;
						mag.x = util.randNum(805,1010);
						mag.y = spnLoc;
						mins.push(mag);
						mag.addEventListener(MouseEvent.MOUSE_DOWN, mDown);		//Mouse event handlers, up then down, the names of the functions however does not need to differ
						mag.addEventListener(MouseEvent.MOUSE_UP, mUp);
						mag.addEventListener(Event.ENTER_FRAME, mRSpn);
					} else {
						addChild(deb);
						deb.x = util.randNum(805,1010);
						deb.y = spnLoc;
						mins.push(deb);
						deb.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
						deb.addEventListener(MouseEvent.MOUSE_UP, mUp);
						deb.addEventListener(Event.ENTER_FRAME, mRSpn);
					}
				break;
			}
		}
		
		
		private var mins:Array = new Array();
		private var mObjID:int = -1;
		private var uniSpeed:Number = 2;
		
		private function mvObj(e:Event):void {
			for (var f:int=0;f<mins.length;f++) {
				if (mObjID == f) {
				} else {
					mins[f].y += uniSpeed;
				}
			}
		}
		
		private function mDown(e:MouseEvent):void {
			if (e.currentTarget.hitTestPoint(mouseX, mouseY, true) && e.currentTarget.alpha >= 1.00) {
				e.currentTarget.startDrag();
				for (var f:int=0;f<mins.length;f++){
					if (e.currentTarget == mins[f]) {
						mObjID = f;
					}
				}
			}
		}
		
		private function mUp(e:MouseEvent):void {
			e.currentTarget.stopDrag();
			if (!e.currentTarget.hitTestObject(cMask) && e.currentTarget.alpha >= 1.00) {
				if (e.currentTarget == "[object dLead]" && e.currentTarget.hitTestObject(lMask)) {
					mins.removeAt(mObjID);
					trace("L");
					e.currentTarget.alpha = 0.99;
					spNum--;
					endR.push(e.currentTarget);
				} else if (e.currentTarget == "[object dSilicon]" && e.currentTarget.hitTestObject(sMask)) {
					mins.removeAt(mObjID);
					trace("S");
					e.currentTarget.alpha = 0.99;
					spNum--;
					endR.push(e.currentTarget);
				} else if (e.currentTarget == "[object dIron]" && e.currentTarget.hitTestObject(iMask)) {
					mins.removeAt(mObjID);
					e.currentTarget.alpha = 0.99;
					trace("I");
					spNum--;
					endR.push(e.currentTarget);
				} else if (e.currentTarget == "[object dQuartz]" && e.currentTarget.hitTestObject(qMask)) {
					mins.removeAt(mObjID);
					trace("Q");
					e.currentTarget.alpha = 0.99;
					spNum--;
					endL.push(e.currentTarget);
				} else if (e.currentTarget == "[object dMagnesium]" && e.currentTarget.hitTestObject(mMask)) {
					mins.removeAt(mObjID);
					trace("M");
					e.currentTarget.alpha = 0.99;
					endL.push(e.currentTarget);
					spNum--;
				} else if (e.currentTarget == "[object dDebris]" && e.currentTarget.hitTestObject(dMask)) {
					mins.removeAt(mObjID);
					trace("D");
					e.currentTarget.alpha = 0.99;
					spNum--;
				} else {
					mins.removeAt(mObjID);
					trace("None");
					e.currentTarget.alpha = 0.80;
					spNum--;
				}
			}
			resetID();
			
		}
		
		private function resetID():void {
			mObjID = -1;
		}
		
		private var overflow:Number = 0;
		private var endR:Array = new Array();
		private var endL:Array = new Array();
		private var xL:Number = 840;
		private var xR:Number = 1000;
		private var end:Boolean = false;
		private var belowT:Number = 800;
		
		private function mRSpn(e:Event):void {
			if (e.currentTarget.y > belowT) {
				e.currentTarget.y = util.randNum(-140,-180);
				e.currentTarget.x = util.randNum(xL,xR);
				if (end == true) {
				} else {
					overflow++
				}
			}
		}
		
		private function colS(colDefP:Object, colDefO:Object): void {
			if (colDefO.hitTestObject(colDefP)) {
				//if (colDefP.x - colDefP.width / 2 <= colDefO.x + colDefO.width && colDefP.x + colDefP.width / 2 >= colDefO.x + colDefO.width && colDefP.curSpeedX < 0) {
				//	//colDefP.curSpeedX = 0;
				//	//left = false;
				//	//colDefP.x = colDefO.x + colDefO.width + 1 + colDefP.width / 2;	
				//} else if (colDefP.x + colDefP.width / 2 >= colDefO.x && colDefP.x - colDefP.width / 2 <= colDefO.x && colDefP.curSpeedX > 0) {
				//	//colDefP.x = colDefO.x - 1 - colDefP.width / 2;
				//	//colDefP.curSpeedX = 0;
				//	//right = false;
				//} else {
					if (colDefP.y - colDefP.height < colDefO.y && colDefP.gravSpeed > 0) {
						colDefP.y = colDefO.y; 
						colDefP.gravSpeed = 0;
					}
					
					//if (colDefP.y > colDefO.y + colDefO.height && colDefP.gravSpeed < 0) {
					//	colDefP.y = colDefO.y + colDefO.height + colDefP.height;
					//	colDefP.gravSpeed = 0;
					//}
				//}
				//Local Handling
				colDefP.isJumping = false;
				colDefP.dJump = false;
			}
		}
	}	
}
