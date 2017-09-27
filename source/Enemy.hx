package;

import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.math.FlxVelocity;
import flixel.tweens.FlxTween;
class Enemy extends FlxSprite
 {
     public var speed:Float = 2.4;
     public var etype(default, null):Int;
	 private var _brain:FSM;
	 private var _idleTmr:Float;
	 private var _moveDir:Int;
	 public var seesPlayer:Bool = false;
	 public var playerPos(default, null):FlxPoint;
	 public var epath:Array<Int>;
	 public var dir_index:Int;
	 public var again:Bool = true;
     public function new(X:Float=0, Y:Float=0, path:Array<Int>, kind:Int, tilesize:Int)
     {
         super(X, Y);if (kind == 0) {
			 loadGraphic("assets/images/Enemy1.png", true);
		 } else if (kind == 1) {
			 loadGraphic("assets/images/Enemy2.png", true);
		 } else {
			 loadGraphic("assets/images/Enemy3.png", true);
		 }
         setFacingFlip(FlxObject.LEFT, false, false);
         setFacingFlip(FlxObject.RIGHT, true, false);
         animation.add("walk", [0, 1], 5, true);
         drag.x = drag.y = 10;
         width = 8;
         height = 14;
         offset.x = 4;
         offset.y = 2;
		 _brain = new FSM(idle);
		 _idleTmr = 0;
		 playerPos = FlxPoint.get();
		 epath = path;
		 // trace(path);
		 dir_index = 0;
		 _moveDir = 1;
		 speed = tilesize/10;
     }
	 
	 public function oppodir(i:Int):Int {
		if (i == 0) {
			return 2;
		} else if (i == 1) {
			return 3;
		} else if (i == 2) {
			return 0;
		} else {
			return 1;
		} 
	}

     override public function draw():Void
     {
         if ((velocity.x != 0 || velocity.y != 0 ) && touching == FlxObject.NONE)
         {
             if (Math.abs(velocity.x) > Math.abs(velocity.y))
             {
                 if (velocity.x < 0)
                     facing = FlxObject.RIGHT;
                 else
                     facing = FlxObject.LEFT;
             }
             else
             {
                 if (velocity.y < 0)
                     facing = FlxObject.UP;
                 else
                     facing = FlxObject.DOWN;
             }

             animation.play("walk");
         }
         super.draw();
     }
	 public function idle():Void
	 {
		 if (seesPlayer)
		 {
			 _brain.activeState = chase;
		 }
		 else
		 {
			var m = epath[dir_index];
			if (_moveDir ==-1) {
				m = oppodir(m);
			}
			
			
			 if (m == 0) {
				 facing = FlxObject.UP;
				 velocity.x = 0;
				 velocity.y = -speed;
				 //velocity.set(0, -speed);
			 } else if (m == 1) {
				 facing = FlxObject.RIGHT;
				 velocity.x = speed;
				 velocity.y = 0;
				 //velocity.set(speed, 0);
			 } else if (m == 2) {
				 facing = FlxObject.DOWN;
				 velocity.x = 0;
				 velocity.y = speed;
				 //velocity.set(0, speed);
			 } else if (m == 3) {
				 facing = FlxObject.LEFT;
				 velocity.x = -speed;
				 velocity.y = 0;
				 //velocity.set(-speed, 0);
			 }
			 // 0 up
			 // 1 right
			 // 2 down
			 // 3 left
			 
			 if (dir_index == 99)
			 {	
				again = !again;
				if (again)
					_moveDir = -1;
				
				 /* epath.reverse();
				 for (d in 0...10) {
					 epath[d] = oppodir(epath[d]);
				 } */
			 } else if (dir_index == 0)  {
				 again = !again;
				 if (again)
					_moveDir = 1;
			 }
			 x += velocity.x;
			 y += velocity.y;
			 //FlxTween.linearMotion(this, this.x, this.y, this.x + velocity.x, this.y + velocity.y, speed, false);
			 if (!again)
				dir_index+=_moveDir;
			 
		 }

	 }

	 public function chase():Void
	 {
		 if (!seesPlayer)
		 {
			 _brain.activeState = idle;
		 }
		 else
		 {
			 FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
		 }
	 } 
	 
	 override public function update(elapsed:Float):Void
	 {
		 _brain.update();
		 super.update(elapsed);
	 }
	 
	 override public function destroy():Void
    {
        super.destroy();
    }
 }