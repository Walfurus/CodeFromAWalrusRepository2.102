package  {
	
	import flash.display.MovieClip;
	
	public class Player extends MovieClip {		//Read the notes carefully in Main if you haven't, you will understand this much better
		
		public var isJumping:Boolean = false;	//Jump Check Variable
		public var dJump:Boolean = true;		//Double Jump Check Variable
		
		public const gravAcc:Number = 2;		//Gravity (y) Ccceleration Constant (unchangeable nor unchanging variable)
		public const gravMax:Number = 30;		//Gravity Cap Constant	(typically used to save on memory)
		private const floatV:Number = 0.4;		//Player Float Constant, How much floating do you want the player to experience (WARNING, Player floating increase is exponential, modify with care)
		public var gravSpeed:Number = 0;		//Current y Speed Variable, more accurately the speed of gravity as the robot isn't actually doing the actuation himself (if you are confused, refer to coding for dummies)
		
		
		private const maxSpeed:Number = 10;		//Maximum x Speed Constant
		public var curSpeed:Number = 0;			//Current x Speed Variable
		
		public function left(): void {			//Left Movement Function (called from Main.as)
			curSpeed = -maxSpeed;				//Sets curSpeed to -curSpeed (sets movement to move left)
		}
		
		public function right(): void {			//Same as above but for right movement
			curSpeed = maxSpeed;
		}
		
		//sY jump speed
		public function jumpStart(sY:Number): void { 		//Jump handler - sY is the total vertical jump value
			if (isJumping == false && gravSpeed == 0){		//Checks to see if the player is both not jumping and completely motionless - this is to prevent the player from jumping multiple times
				isJumping = true;							//Sets jumping to true - as the player is now jumping
				dJump = false;								//Makes sure that the player has not yet double jumped
				gravSpeed = -sY;							//Sets the gravSpeed to the speed determined
			}
		}
		
		public function checkDJump(sY:Number):void {									//Pretty much the same as above other than some funky math issues to allow the player to jump
			if (dJump == false && isJumping == false && Math.abs(gravSpeed) != 0){		//Since the player is jumping and constantly moving, the absolute value is used to determine whether the player has jumped or has touched a platform (there is backups for this check as this is not always the explicit case due to some moving platforms) 
				isJumping = true;														//If isJumping isn't true before, it definitely is now
				dJump = true;															//dJump's true also, no third jumps, thats OP
				gravSpeed = -sY;														//Same process as above
			}
		}
		
		public function jumpStop(): void {										//Stop Accelerating Upwards function
			if (isJumping == true && gravSpeed < 0) {							//Checks to see if the player is still jumping
				isJumping = false;												//Sets the isJumping to false - as the player is no longer jumping past this point, not allowing a double jump
				gravSpeed *= floatV;											//Changes the float value by the floatV, emulates gravity jerk or jump boost
			}
		}
	}
}

