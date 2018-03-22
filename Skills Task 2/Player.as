package  {

	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	
	public class Player extends MovieClip {
	
		private const maxSpeed:Number = 10;
		private var curSpeed:Number = 0;
		
		private var gravSpeed:Number = 0;
		private const gravAcc:Number = 2;
		private const gravMax:Number = 30;
		private var jumpSpeed:Number = 30;

		private var isJumping:Boolean = false;
		private var up:Boolean = false;
		private var left:Boolean = false;
		private var right:Boolean = false;
		
		public function Player() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
			stage.addEventListener(Event.ENTER_FRAME, loopMove);
			trace ("Im Sentient");
		}
		
		private function keyPress(k:KeyboardEvent):void {
			if (k.keyCode == Keyboard.SPACE) {
				if (isJumping == false && gravSpeed == 0){
					isJumping = true;
					up = true;
					gravSpeed = -jumpSpeed;
				}
			}
			
			if (k.keyCode == Keyboard.A){
				left = true;
			}
			
			if (k.keyCode == Keyboard.D){
				right = true;
			}
		}
		
		private function keyRelease(k:KeyboardEvent):void {
			if (k.keyCode == Keyboard.SPACE){
				if (isJumping == true && gravSpeed < 0){
					gravSpeed *= 0.4;
					isJumping = false;
				}
			}
			
			if (k.keyCode == Keyboard.A){
				left = false;
				curSpeed = 0;
			}
			
			if (k.keyCode == Keyboard.D){
				right = false
				curSpeed = 0;
			}
		}
		
		private function loopMove(e:Event):void {
			if (up == true){
				if (gravSpeed > gravMax) {
					gravSpeed = gravMax;
				} else {
					gravSpeed += gravAcc;
				}
				this.y += gravSpeed;
			}
			
			if (left == true){
				curSpeed = -maxSpeed + 1;
			}
			if (right == true){
				curSpeed = maxSpeed;
			}
			this.x += curSpeed;
		}
	}
}
