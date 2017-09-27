package;

import flash.filters.ColorMatrixFilter;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.FlxG;
import flixel.util.FlxStringUtil;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.graphics.FlxGraphic;
import openfl.Assets;
import flixel.tile.FlxBaseTilemap;
import flixel.util.FlxCollision;
import flixel.util.FlxArrayUtil;
import MazeGeneration.*;
import flixel.system.FlxSound;
import flixel.group.FlxGroup.FlxTypedGroup;
class BossState extends FlxState
{
	var _player:Player;
	var _boss1:Boss;
	var _boss2:Boss;
	var _boss3:Boss;
	var ran:Int;
	var heart1:FlxSprite;
	var heart2:FlxSprite;
	var heart3:FlxSprite;
	var heart4:FlxSprite;
	var bossHealth:Int = 3;
	
	var count:Int;
	private var _hud: HUD;
	var _grpAttacks:FlxTypedGroup<Attack>;
	var _grpBosses:FlxTypedGroup<Boss>;
	override public function create():Void
	{	
		super.create();

		// music
		var _loop = FlxG.sound.load("assets/music/BossLoop.wav", 1, true);
		_loop.play();

		// health for keep tracking
		heart1 = new FlxSprite(18*40, 0);
		heart1.loadGraphic("assets/images/heart.png", false, 64, 64);
		heart1.scale.set(40 / 64, 40 / 64);
		heart1.updateHitbox();
		add(heart1);
		heart2 = new FlxSprite(19*40, 0);
		heart2.loadGraphic("assets/images/heart.png", false, 64, 64);
		heart2.scale.set(40 / 64, 40 / 64);
		heart2.updateHitbox();
		add(heart2);
		heart3 = new FlxSprite(20*40, 0);
		heart3.loadGraphic("assets/images/heart.png", false, 64, 64);
		heart3.scale.set(40 / 64, 40 / 64);
		heart3.updateHitbox();
		add(heart3);
		
		
		
		// add attacks
		_grpAttacks = new FlxTypedGroup<Attack>();
		add(_grpAttacks);

		// player
		_player = new Player(_grpAttacks, true);
		_player.scale.set(2, 2);
		_player.x = 0;
		_player.y = 0;
		_player.updateHitbox();
		_player.health = 3;
		add(_player);
		
		// Boss
		_grpBosses = new FlxTypedGroup<Boss>();
		add(_grpBosses);
		_boss1 = new Boss(0);
		_boss1.scale.set(5, 5);
		_boss1.updateHitbox();
		_boss1.x = 420;
		_boss1.y = 420;
		_grpBosses.add(_boss1);
		
		_boss2 = new Boss(1);
		_boss2.scale.set(5, 5);
		_boss2.updateHitbox();
		_boss2.x = 420;
		_boss2.y = 420;
		_grpBosses.add(_boss2);
		
		_boss3 = new Boss(2);
		_boss3.scale.set(5, 5);
		_boss3.updateHitbox();
		_boss3.x = 420;
		_boss3.y = 420;
		_grpBosses.add(_boss3);
	}
	
	override public function update(elapsed:Float):Void
	{
		/* if (FlxG.overlap(_player, _boss1)) {
			_player.health--;
			_hud.updateHUD(_player.health);
		} */
		if (bossHealth == 0) {
			_boss1.destroy();
			_boss2.destroy();
			_boss3.destroy();
		}
		for (i in _grpAttacks) {
			for (j in _grpBosses) {
				if (i._kind == j._kind && FlxG.overlap(i, j)) {
					bossHealth--;
				}
			}
		}

		ran = FlxG.random.int(0, 2);
		if (ran == 0) {
			add(_boss1);
		} else if (ran == 1) {
			add(_boss2);
		} else if (ran == 2) {
			add(_boss3);
		}
		count++;
		super.update(elapsed);
	}

}