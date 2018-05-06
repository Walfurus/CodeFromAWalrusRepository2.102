package {																//Code Package - This is a script and this is the package of code to be imported - applies to every script
	
	//Standard Imports
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.system.System;
	
	import External;													//Importing the External script
	import flash.text.engine.SpaceJustifier;							//Used for centred text

	public class Main extends MovieClip {								//Sets this class to extend Movieclip (be a movieclip) - this whole "movie" is a movieclip (uses frames) - Main is a public class, can be actuated from elsewhere
		//VARIABLES
		//Game Initialisation
		private var gameStart:Boolean = false;							//Begin Game (after start menu)
		private var external:External;									//External Script Caller (initialises external for use within Main)
		
		//Movement Booleans
		private var left: Boolean = false;								//Player Movement Left
		private var right: Boolean = false;								//Player Movement Right
		private var up:Boolean = false;									//Player Movement Jump
		private var jumpSet:Boolean = false;							//Player Movement Double Jump Handler
		
		//Movement Values
		private var jmp = 30;											//Player Jump Speed
		private var dJmp = 30;											//Player Double Jump Speed, I really should make a config file at this point
		
		//Platforms
		private var platID:int = -1;									//Platform ID (discussed later)
		private var platMax:int = 3;									//Max Platforms Allowed
		private var platNum:int = 0;									//Total Number of Platforms
		private var platforms:Array = new Array();						//Collision Array
		
		//Endgame
		private var endAlpha:Number = 1;								//Disappearing Platforms
		
		//Spawning
		private var gndBool:Boolean = false;							//Spawning Variable (discussed later)
		
		//Game Dependables
		private var gndSpeed:Number = 5;								//Scroll Speed
		private var spdAdd:Number = 1;									//Scroll Speed Acceleration
		private var plyScore:Number = 0;								//Player Score
		
		//Object Sizes
		private const bkgXSize:Number = 2283.9;							//Custom backgrounds :D
		
		//Initialisation
		public function Main() {													//This is called at the initialisation of Main, acts like a blank script but can only be initialised once
			stop();																	//Stop on the initialised frame (which just so happens to be 1);
			external = new External();												//Initialises the External script as external object
			startGame.addEventListener(MouseEvent.MOUSE_UP, initGame);				//Button Handlers
			helpGame.addEventListener(MouseEvent.MOUSE_UP, needHelp);
			quitGame.addEventListener(MouseEvent.MOUSE_UP, letsQuit);
			
		}
		
		private function initGame(e:MouseEvent):void {								//Game Initialise - post start menu init
			setupEntity();															//Calls setupEntity function (Object Initialisation)
			gotoAndStop(2);															//Goes and stops on frame 2
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);				//Keyboard key pressed hander
			stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);				//Keyboard key released handler
			stage.addEventListener(Event.ENTER_FRAME, globalLoop);					//Global Loop Handler
		}
		
		private function needHelp(e:MouseEvent):void {								//Button needHelp
			gotoAndStop(61);
			backGame.addEventListener(MouseEvent.MOUSE_UP, moveBack);				//Adds event listeners to the buttons on the respective pages
			quitGame.addEventListener(MouseEvent.MOUSE_UP, letsQuit);
		}
		
		private function moveBack(e:MouseEvent):void {								//Back button, same as above
			gotoAndStop(1);
			startGame.addEventListener(MouseEvent.MOUSE_UP, initGame);
			helpGame.addEventListener(MouseEvent.MOUSE_UP, needHelp);
			quitGame.addEventListener(MouseEvent.MOUSE_UP, letsQuit);
		}
		
		private function letsQuit(e:MouseEvent):void {								//Quit button, look above
			System.exit(0);															//System exit code function 0, standalone adobe player function
		}
		
		//Object Initialisation - Global Main
		private var ply:Player = new Player();						//Player Hitbox Object
		private var plyM:PlyMask = new PlyMask();					//Player Graphic Mask Object
		private var sPlat:SPlat = new SPlat();						//Gamestart realism and immersion platform
		private var bkgL:BkgL = new BkgL();							//Left Background Object - enables smooth scrolling
		private var bkgR:BkgR = new BkgR();							//Right Background Object
		private var endS:EndScreen = new EndScreen();				//Game End Stage Mask Object
		
		public function setupEntity(): void {						//Object Setup function
			//trace("Im Sentient");									//Not Anymore
			plyM.gotoAndStop(1);									//Default player graphic set to 0
			bkgL.x = 0;												//Sets the background X location to 0
			bkgL.y = 0;												//Sets the background Y location to 0
			addChild(bkgL);											//Adds an instance of Background Left
			bkgR.x = bkgXSize;										//Sets the Right Background X to the end of the Left Background
			addChild(bkgR);											//Adds an instance of Background Right
			setupPly();												//Player Setup Function
			sPlat.x = ply.x;										//Sets the total realism platform initially to the player's x location
			sPlat.y = ply.y;										//Sets the entirely immersive platform initllay to the player's y location (same platform as above)
			addChild(sPlat);										//Creates an instance of the entirely realistic total immersion platform
			
			//Initial plat spawn handler
			spawnPlat(300);											//This is to negate issues regarding distance due to the initially slow scroll speed
			spawnPlat(800);											//The randomiser has potential to spawn platforms at a higher distance than the robot could initially make
			spawnPlat(1300);										//This allows a set distance
			spawnPlat(1800);
			spawnPlat(2300);
		}
		
		private function setupPly():void {							//Player Setup Function
			ply.x = 300;											//Sets the default player x location
			ply.y = 100;											//Sets the default player y location
			addChild(ply);											//Adds an instance of the player hitbox
			addChild(plyM);											//Adds an instance of the player mask
			ply.alpha = 0;											//Sets the player hitbox to be invisible by changing the alpha to 0		}
		}
		
		private function spawnPlat(spawnInt:Number):void {
			var gndType = external.randNum(1,3);					//Utilises the random number generator in Extranal.as to generate a random number...obviously
			var gnd:Ground = new Ground();							//Initialises the platforms as an object within the spawnPlat heirarchy level - this spawns the platforms as a new object every time this function runs
			var gndC:GroundC = new GroundC();						//Orientation matters - This must be placed before any calls to these objects
			var gndD:GroundD = new GroundD();
			platNum++											//Increases total platform number for spawning purposes (discussed later);
			
			switch (gndType) {									//Switch of gndType variable
				case 1:											//case of gndType == 1
					gnd.x = spawnInt;							//Changes the x spawn location of the newly formed instance of Ground to be at spawnInt
					gnd.y = external.randNum(150,600);			//Randomises the Y spawn location off screen
					addChild(gnd);								//Adds an instance of gnd (Ground)	
					platforms.unshift(gnd);						//Adds the instance of gnd (Ground) into platforms Array at the beginning (unshift) 
				break;											//Line break, indicates end of sequence
				case 2:											//Same as above but with elevator platform object
					gndC.x = spawnInt;
					gndC.y = external.randNum(150,450);
					addChild(gndC);
					platforms.unshift(gndC);
				break;
				case 3:											//Above but with dropping platform object
					gndD.x = spawnInt;
					gndD.y = external.randNum(150,600);
					addChild(gndD);
					platforms.unshift(gndD);
				break;
			}
		}
		
		private function keyPress(k: KeyboardEvent): void {						//Key down-pressed handler
			if (k.keyCode == Keyboard.SPACE && gameStart == true) {				//Determines whether gamestart is true and if space is pressed by player, prevents the game from running before going to the gamestart frame
				if (left == true && ply.isJumping == false) {					//Player mask direction conditions - The public boolean variable declared within Player script is used here
					plyM.gotoAndStop(4);										//Tells the nested frame within the player mask to go to a specific 
				} else if (right == true && ply.isJumping == false) {			//Checks for walk right - runs if both right variable is true and isJumping is true
					plyM.gotoAndStop(3);										//Goto nested frame 3
				} else {
					if (plyM.currentFrame == 2) {								//Checks the direction the player is facing when space is not pressed mid flight, keeping its orientation
						plyM.gotoAndStop(4);									//Explained above
					} else {
						plyM.gotoAndStop(3);
					}
				}
				ply.jumpStart(jmp);												//Nested function jumpStart with jump height Number variable - sets default y and performs the function
				ply.checkDJump(dJmp);											//Everytime space is pressed, checks for secondary press after the first, checking occures within the function
				up = true;														//Sets variable up to true
				sPlat.alpha = 0;												//Makes sure the sPlat alpha is 0
			} else if (k.keyCode == Keyboard.SPACE) {							//Before the platforms start moving on player contact (gameStart) - pressing space will actuate below
				ply.jumpStart(10);												//Smaller jump for effect
				sPlat.alpha = 0.5;												//Reduces realism platform alpha to half, this is to both to indicate a non active platform and a quick fade (on release)
				up = true;														//Sets up to true as the player is in the air
			}

			if (k.keyCode == Keyboard.A) {										//When keyboard key A is pressed
				left = true;													//Changes left to true - player is allowed to move left
				plyM.gotoAndStop(2);											//Mask goto left walk frame
			} 
			if (k.keyCode == Keyboard.D) {										//Similar to above, except with right movement set to true
				right = true;
				plyM.gotoAndStop(1);
			} 
		}

		private function keyRelease(k:KeyboardEvent):void {						//Release handler, when the key is released
			if (k.keyCode == Keyboard.SPACE && gameStart == true) {				//Checks for gameStart to be true like above with key pressed
				if (left == true) {												//Return to walk left position if left is true
					plyM.gotoAndStop(2);										
				} else if (right == true) {										//Return to walk right position if right is true - else if so left takes priority, defaults to left if both buttons are pressed (for some epic moon jumping)
					plyM.gotoAndStop(1);
				} else {														//Checks for mid flight direction
					if (plyM.currentFrame == 4) {
						plyM.gotoAndStop(2);
					} else {													//If not facing left (else) go to face right
						plyM.gotoAndStop(1);
					}
				}
				ply.jumpStop();													//Stop vertical momentum - controlled jumps
				jumpSet = true;													//Sets jumpSet to true - Enables double jump
			} else if (k.keyCode == Keyboard.SPACE) {
				sPlat.alpha = 0;												//Sets the spawn platform alpha to 0, it is actuated post first release but adobe flash player is smart enough to realise it does nothing, memory +1
			}
			
			if (k.keyCode == Keyboard.A) {										//Sets left to false, no longer allowed to move left
				left = false;
				ply.curSpeed = 0;												//Sets the current speed of the player to 0, stationary - this speed is x determined within the movement function in Player script
			}

			if (k.keyCode == Keyboard.D) {										//Like above but with right
				right = false
				ply.curSpeed = 0;
			}
		}
		
		public function globalLoop(e:Event): void {								//The global loop, for all your looping needs
			
			while (platNum < platMax && gndBool == true) {						//While loop that handles spawning, checks if both the total number of platforms is less than the maximum allowed and if spawning (gndBool) is allowed (true)
				spawnPlat(external.randNum(1000,1300));							//Spawn a platform off screen at a random x location between the two values
			}
			
			score.text = String(plyScore);										//Constantly updates the score textbox to equal the playerscore with inbuilt toString function
			
			stage.focus = stage;												//constantly re-focuses the window (to the stage) - clicking with the mouse by default sets the focus to whatever is clicked, this circumnavigates that issue by constantly refocusing the window to the stage, allowing for player movement 
			
			if (ply.x <= 0) {													//Artificial x wall at 0
				ply.x = 0;														//Constantly resets player position to the wall location.
			}
			
			if (ply.x >= 960) {													//Another artificial wall at the other end of the stage
				ply.x = 960;
			}
			
			if (ply.y >= 720) {													//If the player falls off the stage
				endGame();														//Trigger Game Over
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);	//Remove movement handlers, the global loop (a self destruct button)
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyRelease);
				stage.removeEventListener(Event.ENTER_FRAME, globalLoop);
				addEventListener(Event.ENTER_FRAME, endLoop);					//starts the end game sequence loop
			}
			
			if (gameStart == true) {											//Checks for gamestart to be true
				bkgL.x -= gndSpeed;												//Scrolls the background according to the platform scroll speed (helps with motion sickness with some individuals)
				bkgR.x -= gndSpeed;												//Both backgrounds, gotta be both, can't be just one
			} else {
				sPlat.x = ply.x;												//constantly sets the start platform to right underneath the player x, simulates movement
			}
			
			if (bkgL.x <= -bkgXSize) {											//Checks when one background completely exits the stage
				bkgL.x = bkgR.x + bkgXSize;										//Respawns the background at the end of the other background
			}
			
			if (bkgR.x <= -bkgXSize) {											//As above
				bkgR.x = bkgL.x + bkgXSize;
			}
			
			plyM.x = ply.x;														//Constantly sets the player mask location to that of the player location
			plyM.y = ply.y;														//Note: The player mask is determined 1 frame later than that of the hitbox even though they should be identically together, this is due to how the flash player handles enter frames 1 frame later than the initialisation loops
			ply.x += ply.curSpeed;												//Determines how fast the player moves from side to side by adding the curSpeed variable to the player x
			
			if (up == true) {													//Player jump handler
				if (ply.gravSpeed > ply.gravMax) {								//Checks if player is not falling faster than the maximum allowed speed
					ply.gravSpeed = ply.gravMax;								//Sets the fall speed to be that of the maximum
				} else {
					ply.gravSpeed += ply.gravAcc;								//Else accelerates the player downwards at the determined acceleration speed
				}
				ply.y += ply.gravSpeed;											//Sets the player jump speed to be that of the changing acceleration speed
			}
			
			if (left == true) {													//If left is true, actuate left function within player
				ply.left();
			}
			if (right == true) {												//Same thing as above but with right
				ply.right();
			}
			
			for (var i:int;i<platforms.length;i++) {							//Array for loop - determines the length of the array and spawns platforms
				colS(ply,platforms[i]);											//Update the collision between the player and all platforms within platforms array
				
				if (gameStart == true) {										//If gamestart variable is true (is the game starting)
					platforms[i].x -= gndSpeed;									//Start moving the platforms left at the scroll speed
				}
			
				if (platforms[i].checkHit(ply) == true) {						//Check if the platform hits the player using the platform hitchecker function
					switch (platforms[i].checkID()) {							//Switch function to check the type of platform
						case 2:													//Elevator platform
							if (platforms[i].y >= 80) {							//Checks if the platform is lower than max height 
								platforms[i].y -= 8;							//Moves the platform upwards at that speed
								ply.y -= 10;									//Makes sure the player moves with the platform or weird bobbing happens - value is higher to offset default player downwards movement
							}
						break;
						case 3:
							ply.y += 9;											//Moves player downwards at speed declared (not exact due to the collision of player, close enough)
							platforms[i].y += 7;								//Like above with the player
						break;
					}
					
					//Player on platform movement
					if (left == false && right == false) {						//Checks if the player is not moving on the platform
						ply.x -= gndSpeed;										//Player moves with the platform
						gameStart = true;										//Just to make sure the game starts
					} else if (left == true) {									//Makes the player move with equal speed on the platform as in the air for some of that relativity goodness
						ply.x -= gndSpeed;
						gameStart = true;										//Very sure
					} else if (right == true) {									//Since the player moves anyway when going against the scroll speed, no need for speed change
						gameStart = true;										//Very very sure
					}
				}
				
				if (platforms[0].x < 500 && gameStart == true) {				//If the game starts and the inital x is smaller than 500
					gndBool = true;												//Sets the spawn variable to true (enable spawning)
				} else {
					gndBool = false;											//Else false (disable spawning)
				}
				
				if (platforms[i].x < -400) {									//Platform removal when the platform is 100 x pixels beyond the left of the stage (as the platforms are by default 300 x in size with top left registration)
					platforms.removeAt(i);										//Remove the platform at the length of the Array (as the platforms are shifted into the array (inserted at the beginning (notice the commentception)))
					platNum--													//Decreases the total number of registered existant platforms to enable spawning and avoid confusion (not the programmer's confusion which it only adds upon)
					plyScore++													//Increases the score by 1 - works for a non linear score increase, the player should be parabolically rewarded
					if (gndSpeed <= 25) {										//If the speed of the ground is smaller or equal to 25
						gndSpeed = gndSpeed + spdAdd;							//Adds spdAdd variable upon the existing speed (basically increases the speed), a bit unnecessary if the value is 1 (you could just do it with gndSpeed++) but where is the fun in necessity
					}
				}
			}
		}
		
		private function endLoop(e:Event):void {								//Endgame loop - a quick loop performed to transition out of the game stage to the end scene
			endAlpha = endAlpha - 0.015;										//Lowers endAlpha by 0.015 every tick (in this case framerate)
			for (var i:int;i<platforms.length;i++) {							//Basic for loop within the endLoop regarding the total number of unshifted variables in the platforms array - performs tasks specified on all members of the array
				platforms[i].alpha = endAlpha;									//Every Platform's alpha becomes the endAlpha value
				
				if (endS.currentFrame == 90) {									//If endS is on the last frame, 
					gotoAndPlay(3);												//Go and play from frame 3
					endS.gotoAndStop(1);										//Stops the endS stage mask on frame 1 without re-looping, complete darkness
					bkgL.y = 9000;												//Sets both backgrounds to somewhere out of sight, as x still moves, this is done with y
					bkgR.y = 9000;
				}
				
				if (this.currentFrame == 60) {									//As Main is the class handler for this "Movie", when the game reaches frame 60
					stop();														//Stop on frame 60
					endTxt.text = String(plyScore);								//Sets the endTxt text box to display the playerscore using an inbuilt toString function
					removeEventListener(Event.ENTER_FRAME, endLoop);			//Removes the endLoop
				}
			}
		}
		
		private function endGame():void {										//Game over function - player fell
			addChild(endS);														//Adds the end screen mask - huge black square
			endS.gotoAndPlay(1);												//Plays the frames nested within endS from 1
		}
		
		//Local Collision Handler
		private function colS(colDefP:Object, colDefO:Object): void {			//Collision function - universal collision for any object with a registration point at the center bottom against top left corner
			if (colDefO.hitTestObject(colDefP)) {								//If the collision player/object 1 first hits any point point of the object hitbox (massive square) using default collision test function
				if (colDefP.x - colDefP.width / 2 <= colDefO.x + colDefO.width && colDefP.x + colDefP.width / 2 >= colDefO.x + colDefO.width && colDefP.curSpeed < 0) {			//Object x collision if statement
					colDefP.x = colDefO.x + colDefO.width + 1 + colDefP.width / 2;																								//Returns the objectP x to the edge of object O x
					colDefP.curSpeed = 0;													//Sets the speed of the objectP to 0 so it cannot travel through objectO
					left = false;															//Sets left to false, can no longer move left
				} else if (colDefP.x + colDefP.width / 2 >= colDefO.x && colDefP.x - colDefP.width / 2 <= colDefO.x && colDefP.curSpeed > 0) {		//Same as above but with right
					colDefP.x = colDefO.x - 1 - colDefP.width / 2;
					colDefP.curSpeed = 0;
					right = false;
				} else {													//If neither x hits the object, check for y
					if (colDefP.y - colDefP.height < colDefO.y) {
						colDefP.y = colDefO.y;
						colDefP.gravSpeed = 0;								//Sets the gravity speed to 0, no longer falling
					}
					
					if (colDefP.y > colDefO.y + colDefO.height && colDefP.gravSpeed < 0) {		//If objectP is contacts below objectO, also collide
						colDefP.y = colDefO.y + colDefO.height + colDefP.height;
						colDefP.gravSpeed = 0;
					}
				}
				//Local Handling
				colDefP.isJumping = false;			//Sets Player variable isJumping to false (Player is no longer considered jumping)
				colDefP.dJump = false;				//Sets Player variable dJump to false (Player is no longer considered double jumping)
			}
		}
	}
}

