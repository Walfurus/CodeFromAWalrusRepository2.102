package  {
	import flash.display.MovieClip;
	
	public class Player extends MovieClip {
		
		public var isJumping:Boolean = false;	//Jump Check Variable
		public var dJump:Boolean = false;
		
		public const gravAcc:Number = 1;		//Gravity (y) Ccceleration Constant (unchangeable nor unchanging variable)
		public const gravMax:Number = 25;		//Gravity Cap Constant	(typically used to save on memory)
		private const floatV:Number = 0.4;		//Player Float Constant, How much floating do you want the player to experience (WARNING, Player floating increase is exponential, modify with care)
		public var gravSpeed:Number = 0;
		public var flyMax:Number = -10;
		public var flyAcc:Number;
		
		private const maxSpeed:Number = 5;		//Maximum x Speed Constant
		public var curSpeedX:Number = 0;
		public var curSpeedY:Number = 0;
		
		public var curJump:Boolean = false;
		
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
				dJump = false;	
				gravSpeed = -sY;
				//trace ("hi");
			}
		}
		
		public function checkDJump(sY:Number):void {
			if (dJump == false && isJumping == false && Math.abs(gravSpeed) != 0){
				isJumping = true;
				dJump = true;
				gravSpeed = -sY;
				trace ("hi")
			}
		}
		
		public function checkFly(sY:Number):void {
			if (isJumping == true) {
				if (gravSpeed >= flyMax) {
					gravSpeed -= sY;
				} else {
					gravSpeed = flyMax;
				}
			}
		}
		
		public function jumpStop(): void {
			if (gravSpeed < 0) {
				isJumping = false;
				gravSpeed *= floatV;
			}
		}
	}
}