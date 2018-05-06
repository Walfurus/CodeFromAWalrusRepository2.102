package  {
	
	import flash.display.MovieClip;
	
	public class Ground extends MovieClip {		//If you don't know what this does, you haven't carefully read the notes in Main yet
		
		private var returnBool:Boolean = false;			//Private return boolean, by default false
		private var objID:int = 1;						//This object's ID - private return integer
		
		public function checkHit(obj:MovieClip):Boolean {		//Public boolean function (quick true or false test)
			if (this.hitTestObject(obj)) {						//Checks if this object is colliding with an object
				returnBool = true;								//sets the return function to true - defaults to false
			}
			return (returnBool);								//Returns the value of returnBool for use by Main when checked
		}
		
		public function checkID():int {							//Integer return function
			return (objID);										//Returns the objID
		}														//Note 1: This is overkill for only 1 platform but since there is multiple platforms, this actually saves on writing later down the line.
	}															//Note 2: For platform actuations, refer to Main.as
}																//Note 3: For more of the same, refer to GroundD.as or GroundC.as
