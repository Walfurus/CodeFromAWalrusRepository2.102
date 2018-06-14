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
		
		public function Main() {
			stage.addEventListener(Event.ENTER_FRAME, globalLoop);
			forwards.addEventListener(MouseEvent.CLICK, fwdCom);
			jmp.addEventListener(MouseEvent.CLICK, jmpCom);
			setupPly();
		}
		
		private function setupPly():void {
			ply.x = 300;
			ply.y = 100;
			addChild(ply);
		}
		
		private var ckCom:Boolean = false;
		private var jmpCom:Boolean = false;
		
		private function fwdCom(e:MouseEvent):void {
			ckCom = true;
			timeC.start();
			timeC.addEventListener(TimerEvent.TIMER_COMPLETE, endCom);
		}
		
		private function jmpCom(e:MouseEvent):void {
			jmpCom:Boolean = true;
		}
		
		private function endCom(e:TimerEvent):void {
			ckCom = false;
		}
		
		private var dly:uint = 3000;
		private var rpt:uint = 1;
		private var timeC:Timer = new Timer(dly,rpt);
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
			
			ply.x += ply.curSpeed;
			colS(ply,gnd);
			
			if (ckCom == true) {
				ply.right();
				trace(debug)
				debug++;
			} else {
				ply.stopPly();
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
