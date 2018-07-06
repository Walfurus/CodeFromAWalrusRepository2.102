﻿package  {
	import flash.display.MovieClip;
	
	public class Player extends MovieClip {
		
		public var isJumping:Boolean = false;	//Jump Check Variable
		
		public const gravAcc:Number = 1;		//Gravity (y) Ccceleration Constant (unchangeable nor unchanging variable)
		public const gravMax:Number = 25;		//Gravity Cap Constant	(typically used to save on memory)
		private const floatV:Number = 0.4;		//Player Float Constant, How much floating do you want the player to experience (WARNING, Player floating increase is exponential, modify with care)
		public var gravSpeed:Number = 0;		//Current y Speed Variable, more accurately the speed of gravity as the robot isn't actually doing the actuation himself (if you are confused, refer to coding for dummies)
		
		
		private const maxSpeed:Number = 5;		//Maximum x Speed Constant
		public var curSpeedX:Number = 0;
		public var curSpeedY:Number = 0;			
		
		public function left(sL:Number):void {
			curSpeedX = -sL;
		}
		
		public function right(sR:Number):void {
			curSpeedX = sR;
		}
		
		public function up(sU:Number):void {
			curSpeedY = -sU;
		}
		
		public function down(sD:Number):void {
			curSpeedY = sD;
		}
		
		public function stopPly():void {
			curSpeedX = 0;
			curSpeedY = 0;
		}
		
		public function jumpStart(sY:Number): void {
			if (isJumping == false && gravSpeed == 0){
				isJumping = true;
				gravSpeed = -sY;
			}
		}
		
		public function jumpStop(): void {
			if (isJumping == true && gravSpeed < 0) {
				isJumping = false;
				gravSpeed *= floatV;
			}
		}
	}
}

//alex is the best friend I've ever had, I leave all of my posessions to him when I die