package;

import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.math.FlxVelocity;
import flixel.tweens.FlxTween;
class Boss extends FlxSprite
 {
	public var _kind:Int;
     public function new(kind:Int)
     {
		 _kind = kind;
        super();
		if (kind == 0) {
			loadGraphic("assets/images/Enemy1.png", true);
		} else if (kind == 1) {
			loadGraphic("assets/images/Enemy2.png", true);
		} else {
			loadGraphic("assets/images/Enemy3.png", true);
		}
        animation.add("walk", [0, 1, 0, 1], 5, true);
     }
	 


	 
	 override public function update(elapsed:Float):Void
	 {
		 var i = FlxG.random.int(0, 2); 
		 animation.play("walk");
		 super.update(elapsed);
	 }
	 
	 override public function destroy():Void
    {
        super.destroy();
    }
 }