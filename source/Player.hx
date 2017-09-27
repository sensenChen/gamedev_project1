package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;

class  Player extends FlxSprite
{
	var speed:Float = 150;
	var _rot:Float = 0;
	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;
	var _butt:Bool = false;
	var _kick:Bool = false;
	var _kiss:Bool = false;
	var _boss:Bool;
	var attackArray:FlxTypedGroup<Attack>;
	public function new(playerAttackArray:FlxTypedGroup<Attack>, boss:Bool) 
	{
		super();
		loadGraphic("assets/images/Our Dude_64x64.png", true, 64, 64);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("right", [2, 3], 5, true);
		animation.add("left", [0, 1], 5, true);
		animation.play("right");
		drag.x = drag.y = 2000;
		attackArray = playerAttackArray;
		_boss = boss;
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
				animation.play("left");
				facing = FlxObject.LEFT;
			} else if (_right) {
				_rot = 0;
				animation.play("right");
				facing = FlxObject.RIGHT;
			} else if (_down) {
				_rot = 90;
				animation.play("right");
				facing = FlxObject.DOWN;
			} else {
				_rot = 270;
				animation.play("left");
				facing = FlxObject.UP;
			}
			velocity.set(speed, 0);
			velocity.rotate(new FlxPoint(0, 0), _rot);
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
		var newAttack;
		if (!_boss)
			newAttack = new Attack(x+24/2-20/2, y+24/2-20/2, 500, facing, _attackKind, 20);
		else 
			newAttack = new Attack(x+24/2-128/2, y+24/2-128/2, 500, facing, _attackKind, 64*2);
		attackArray.add(newAttack);
	}
}