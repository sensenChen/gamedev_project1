import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxVelocity;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
class Attack extends FlxSprite
{
 
    private var speed:Float;
    private var direction:Int;
	private var _rot:Float = 0;
	private var _kiss:FlxSound;
	public var _kind:Int;
    public function new(X:Float, Y:Float,Speed:Float,Direction:Int,Kind:Int, Scale:Int)
    {
        super(X, Y);
		_kind = Kind;
        speed = Speed;
        direction = Direction;
		if (Kind == 0) {
			loadGraphic("assets/images/butt.png", false, 64, 64);
		} else if (Kind == 1) {
			loadGraphic("assets/images/kick.png", false, 64, 64); 
		} else if (Kind == 2) {
			loadGraphic("assets/images/kiss.png", false, 64, 64);
		}
		_kiss = FlxG.sound.load("assets/sounds/Kiss1.wav", 1, false);
		_kiss.play();
		scale.set(Scale / 64, Scale / 64);
		
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