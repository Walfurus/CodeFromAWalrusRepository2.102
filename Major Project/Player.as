package  {
	import flash.display.MovieClip;
	
	public class Player extends MovieClip {
		
		public var isJumping:Boolean = false;	//Jump Check Variable
		
		public const gravAcc:Number = 2;		//Gravity (y) Ccceleration Constant (unchangeable nor unchanging variable)
		public const gravMax:Number = 15;		//Gravity Cap Constant	(typically used to save on memory)
		private const floatV:Number = 0.4;		//Player Float Constant, How much floating do you want the player to experience (WARNING, Player floating increase is exponential, modify with care)
		public var gravSpeed:Number = 0;		//Current y Speed Variable, more accurately the speed of gravity as the robot isn't actually doing the actuation himself (if you are confused, refer to coding for dummies)
		
		
		private const maxSpeed:Number = 5;		//Maximum x Speed Constant
		public var curSpeed:Number = 0;			//Current x Speed Variable
		
		public function left():void {			//Left Movement Function (called from Main.as)
			curSpeed = -maxSpeed;				//Sets curSpeed to -curSpeed (sets movement to move left)
		}
		
		public function right():void {			//Same as above but for right movement
			curSpeed = maxSpeed;
		}
		
		public function stopPly():void {
			curSpeed = 0;
		}
		
		public function jumpStart(sY:Number): void { 		//Jump handler - sY is the total vertical jump value
			if (isJumping == false && gravSpeed == 0){		//Checks to see if the player is both not jumping and completely motionless - this is to prevent the player from jumping multiple times
				isJumping = true;							//Sets jumping to true - as the player is now jumping
				gravSpeed = -sY;							//Sets the gravSpeed to the speed determined
			}
		}
		
		private function jumpStop(): void {										//Stop Accelerating Upwards function
			if (isJumping == true && gravSpeed < 0) {							//Checks to see if the player is still jumping
				isJumping = false;												//Sets the isJumping to false - as the player is no longer jumping past this point, not allowing a double jump
				gravSpeed *= floatV;											//Changes the float value by the floatV, emulates gravity jerk or jump boost
			}
		}
	}
}

//alex is the best friend I've ever had, I leave all of my posessions to him when I die