package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxObject;

class  Player extends FlxSprite
{
	var speed:Float = 100;
	var _rot:Float = 0;
	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;

	public function new() 
	{
		super();
		loadGraphic("assets/images/duck.png", true, 100, 114);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("walk", [0, 1, 0, 2], 5, true);
		drag.x = drag.y = 2000;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed); 
		poll();
		movement();
	}
	
	function poll():Void
	{
		_up = FlxG.keys.anyPressed([UP, W]);
		_down = FlxG.keys.anyPressed([DOWN, S]);
		_left = FlxG.keys.anyPressed([LEFT, A]);
		_right = FlxG.keys.anyPressed([RIGHT, D]);
	}
	
	function movement():Void
	{
		if (_up || _down || _left || _right)
		{
			if (_left) {
				_rot = 180;
				facing = FlxObject.LEFT;
			} else if (_right) {
				_rot = 0;
				facing = FlxObject.RIGHT;
			} else if (_down) {
				_rot = 90;
				facing = FlxObject.DOWN;
			} else {
				_rot = 270;
				facing = FlxObject.UP;
			}
			velocity.set(speed, 0);
			velocity.rotate(new FlxPoint(0, 0), _rot);
			animation.play("walk");
		}
		else {
			animation.stop();
		}
	}
}