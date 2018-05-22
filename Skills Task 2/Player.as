package  {
	
	import flash.display.MovieClip;
	
	public class Player extends MovieClip {
		
		public var isJumping:Boolean = false;
		public var dJump:Boolean = true;
		
		public const gravAcc:Number = 2;
		public const gravMax:Number = 30;
		public var gravSpeed:Number = 0;
		
		private const maxSpeed:Number = 10;
		public var curSpeed:Number = 0;
		
		public function left(): void {
			curSpeed = -maxSpeed;
		}
		
		public function right(): void {
			curSpeed = maxSpeed;
		}
		
		//sY jump speed
		public function jumpStart(sY:Number): void { 
			if (isJumping == false && gravSpeed == 0){
				isJumping = true;
				dJump = false;
				gravSpeed = -sY;
				trace ("jumping")
			}
		}
		
		public function checkDJump(sY:Number):void {
			if (dJump == false && isJumping == false && Math.abs(gravSpeed) > 0){
				isJumping = true;
				dJump = true;
				gravSpeed = -sY;
				trace ("its me");
			}
		}
		
		public function jumpStop(): void {
			if (isJumping == true && gravSpeed < 0) {
				isJumping = false;
				gravSpeed *= 0.4;
			}
		}
	}
}

