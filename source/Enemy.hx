package;
import flixel.FlxSprite;
import flixel.FlxObject;
/**
 * ...
 * @author ...
 */
class Enemy extends FlxSprite 
{
	public var speed:Float = 140;
	public var etype(default, null):Int;
	
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
		movement();
	}
	
	
	function movement():Void
	{
		 if ((velocity.x != 0 || velocity.y != 0 ) && touching == FlxObject.NONE)
         {
             if (Math.abs(velocity.x) > Math.abs(velocity.y))
             {
                 if (velocity.x < 0)
                     facing = FlxObject.LEFT;
                 else
                     facing = FlxObject.RIGHT;
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
	}
}