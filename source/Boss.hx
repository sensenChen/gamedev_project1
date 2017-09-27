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
		loadGraphic("assets/images/Final Boss.png", true, 90, 126);
		if (kind == 0) {
			animation.add("boss1", [0, 1], 5, true);
		} else if (kind == 1) {
			animation.add("boss2", [2, 3], 5, true);
		} else {
			animation.add("boss3", [4, 5], 5, true);
		}
		immovable = false;
     }
	 


	 
	 override public function update(elapsed:Float):Void
	 {
		 var i = FlxG.random.int(0, 2); 
		 if (_kind == 0) {
			animation.play("boss1");
		} else if (_kind == 1) {
			animation.play("boss2");
		} else {
			animation.play("boss3");
		}
		 super.update(elapsed);
	 }
	 
	 override public function destroy():Void
    {
        super.destroy();
    }
 }