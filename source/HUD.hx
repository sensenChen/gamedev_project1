package;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
/**
 * ...
 * @author ...
 */
class HUD extends FlxSpriteGroup 
{
	private var healthDisplay:FlxText;
	private var levelDisplay:FlxText;
	private var healthBar:FlxBar;
	
	private var hp:Float;
	private var maxHp:Float;
	private var level:Float;
	
	public function new(p:Dynamic) 
	{
		super();
		scrollFactor.x = 0;
		scrollFactor.y = 0;
		
		healthDisplay = new FlxText(2, 2);
		hp = 0;
		maxHp = 5;
		add(healthDisplay);
		
		levelDisplay = new FlxText(2, 12);
		level = 1;
		add(levelDisplay);
		
		healthBar = new FlxBar(4, 25, FlxBarFillDirection.LEFT_TO_RIGHT, 30, 4, p, "health", 0, 10, false);
		healthBar.createFilledBar(0xfffe1b4b, 0xffff7a96);
		add(healthBar);
	}
	
	public function updateHUD(health:Float):Void {
		hp = health;
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		healthBar.value = hp;
		healthBar.setRange(0, maxHp);
		healthBar.trackParent(0, -5);
	}
	

}