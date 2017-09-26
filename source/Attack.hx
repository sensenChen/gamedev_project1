import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxVelocity;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
 
class Attack extends FlxSprite
{
 
    private var speed:Float;
    private var direction:Int;
	private var _rot:Float = 0;
    public function new(X:Float, Y:Float,Speed:Float,Direction:Int,Kind:Int)
    {
        super(X,Y);
        speed = Speed;
        direction = Direction;
		loadGraphic("assets/images/Attacks_64x64x3.png", false, 64, 64);
		scale.set(40 / 64, 40 / 64);
		updateHitbox();
		setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);
		
    }
 
    override public function update(elapsed:Float):Void
    {
		if (direction == FlxObject.LEFT) {
			_rot = 180;
			velocity.x = -speed; 
		} else if (direction == FlxObject.RIGHT) {
			_rot = 0;
			velocity.x = speed; 
		} else if (direction == FlxObject.DOWN) {
			_rot = 90;
			velocity.y = speed; 
		} else if (direction == FlxObject.UP) {
			_rot = 270;
			velocity.y = -speed; 
		}
		velocity.set(speed, 0);
		velocity.rotate(new FlxPoint(0, 0), _rot);
		super.update(elapsed);
    }
 
    override public function destroy():Void
    {
        super.destroy();
    }
 
}