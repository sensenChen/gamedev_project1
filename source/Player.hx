package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;

class  Player extends FlxSprite
{
	var speed:Float = 300;
	var _rot:Float = 0;
	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;
	var _butt:Bool = false;
	var _kick:Bool = false;
	var _kiss:Bool = false;
	var attackArray:FlxTypedGroup<Attack>;
	public function new(playerAttackArray:FlxTypedGroup<Attack>) 
	{
		super();
		loadGraphic("assets/images/duck.png", true, 100, 114);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("walk", [0, 1, 0, 2], 5, true);
		drag.x = drag.y = 2000;
		attackArray = playerAttackArray;
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
		_butt = FlxG.keys.justPressed.ONE;
		_kick = FlxG.keys.justPressed.TWO;
		_kiss = FlxG.keys.justPressed.THREE;
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
		else if (_butt || _kick || _kiss) {
			if (_butt) {
				attack(0);
			} else if (_kick) {
				attack(1);
			} else if (_kiss) {
				attack(2);
			}
		}
		else {
			animation.stop();
		}
	}
	private function attack(_attackKind:Int):Void {
		var newAttack = new Attack(x, y, 500, facing, _attackKind);
		attackArray.add(newAttack);
	}
}