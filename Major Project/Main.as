package  {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Main extends MovieClip {
		
		private var left: Boolean = false;
		private var right: Boolean = false;
		private var up:Boolean = false;
		private var jumpSet:Boolean = false;
		
		private var jmp = 30;
		
		private var ply:Player = new Player();
		
		private var commands:Array = new Array();
		
		public function Main() {
			stage.addEventListener(Event.ENTER_FRAME, globalLoop);
			forwards.addEventListener(MouseEvent.CLICK, fwdCom);
			execute.addEventListener(MouseEvent.CLICK, runCommands);
			setupPly();
		}
		
		private function setupPly():void {
			ply.x = 300;
			ply.y = 100;
			addChild(ply);
		}
		
		private var ckCom:Boolean = false;
		private var jumpCom:Boolean = false;
		
		
		//ckCom = true;
		//timeC.start();
		//timeC.addEventListener(TimerEvent.TIMER_COMPLETE, endCom);
		
		private var placeLocX:Number = 254;
		private var placeLocY:Number = 554;
		private var delayAdd:Number;
		
		private var delayBool:Boolean = false;
		
		private function fwdCom(e:MouseEvent):void {
			var forPlace:seqFor = new seqFor();
			forPlace.exeTime = Number(inputTest.text);
			trace(forPlace.exeTime);
			forPlace.x = placeLocX;
			forPlace.y = placeLocY;
			addChild(forPlace);
			commands.push(seqFor);
			placeLocX += 100;
			trace (commands);
			delayBool = true;
		}
		
		private function runCommands(e:MouseEvent):void {
			
		}
		
		private function endCom(e:TimerEvent):void {
			ckCom = false;
		}
		
		private var dly:uint = 3000;
		private var rpt:uint = 1;
		private var timeC:Timer = new Timer(dly,rpt);
		//private var timeD:Timer = new Timer(dlyC,rptC);
		private var debug:Number = 0;
		
		private function globalLoop(e:Event):void {
			if (up == false) {
				if (ply.gravSpeed > ply.gravMax) {
					ply.gravSpeed = ply.gravMax;
				} else {
					ply.gravSpeed += ply.gravAcc;
				}
				ply.y += ply.gravSpeed;
			}
			
			dly = commands[0].exeTime;
			
			
			ply.x += ply.curSpeed;
			colS(ply,gnd);
			
			if (ckCom == true) {
				ply.right();
				trace(debug)
				debug++;
			} else {
				ply.stopPly();
			}
			
			if (jumpCom == true) {
				ply.jumpStart(30);
				jumpCom = false;
			}
		}
		
		private function colS(colDefP:Object, colDefO:Object): void {
			if (colDefO.hitTestObject(colDefP)) {
				if (colDefP.x - colDefP.width / 2 <= colDefO.x + colDefO.width && colDefP.x + colDefP.width / 2 >= colDefO.x + colDefO.width && colDefP.curSpeed < 0) {
					colDefP.x = colDefO.x + colDefO.width + 1 + colDefP.width / 2;
					colDefP.curSpeed = 0;
					left = false;
				} else if (colDefP.x + colDefP.width / 2 >= colDefO.x && colDefP.x - colDefP.width / 2 <= colDefO.x && colDefP.curSpeed > 0) {
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
				//Local Handling
				colDefP.isJumping = false;
			}
		}
	}	
}
