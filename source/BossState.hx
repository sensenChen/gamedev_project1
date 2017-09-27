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
	var ran:Int = 0;
	var heart1:FlxSprite;
	var heart2:FlxSprite;
	var heart3:FlxSprite;
	var bossHealth:Int = 3;
	var num1:Int = 0;
	var num2:Int = 1;
	var num3:Int = 2;
	var numHearts:Int = 3;
	var healthDisplay:FlxText;
	var count:Int = 0;
	var text:flixel.text.FlxText;
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
		heart1 = new FlxSprite(1*24, 0);
		heart1.loadGraphic("assets/images/heart.png", false, 64, 64);
		heart1.scale.set(24 / 64, 24 / 64);
		heart1.updateHitbox();
		add(heart1);
		heart2 = new FlxSprite(2*24, 0);
		heart2.loadGraphic("assets/images/heart.png", false, 64, 64);
		heart2.scale.set(24 / 64, 24 / 64);
		heart2.updateHitbox();
		add(heart2);
		heart3 = new FlxSprite(3*24, 0);
		heart3.loadGraphic("assets/images/heart.png", false, 64, 64);
		heart3.scale.set(24 / 64, 24 / 64);
		heart3.updateHitbox();
		add(heart3);
		
		
		
		// add attacks
		_grpAttacks = new FlxTypedGroup<Attack>();
		add(_grpAttacks);

		// player
		_player = new Player(_grpAttacks, true);
		_player.scale.set(2, 2);
		_player.x = 50;
		_player.y = 220;
		_player.updateHitbox();
		_player.health = 3;
		add(_player);
		
		// Boss
		_grpBosses = new FlxTypedGroup<Boss>();
		_boss1 = new Boss(num1);
		_boss1.scale.set(1.5, 1.5);
		_boss1.updateHitbox();
		_boss1.x = 300;
		_boss1.y = 200;
		_grpBosses.add(_boss1);
		
		_boss2 = new Boss(num2);
		_boss2.scale.set(1.5, 1.5);
		_boss2.updateHitbox();
		_boss2.x = 300;
		_boss2.y = 200;
		_grpBosses.add(_boss2);
		
		_boss3 = new Boss(num3);
		_boss3.scale.set(1.5, 1.5);
		_boss3.updateHitbox();
		_boss3.x = 300;
		_boss3.y = 200;
		_grpBosses.add(_boss3);
		
		// boss health display
		healthDisplay = new FlxText(15*24, 4, 500, "Boss health: " + bossHealth + "/" + 3, 20);
		add(healthDisplay);
		
		// Instructions
		text = new flixel.text.FlxText(50, 50, 500, "ATTACK: \n1 - Kissy lips: Deals Green Damage\n2 - Rockette Rocket Leg (RRL): Deals Purple Damage\n3 - Heres My Underwear : Deals Red Damage\n", 15);
		add(text);
	}
	
	override public function update(elapsed:Float):Void
	{
		if (bossHealth == 0) {
			FlxG.switchState(new TextState3());
		}
		healthDisplay.text = "Boss health: " + bossHealth + "/" + 3;
		for (i in _grpAttacks) {
			for (j in _grpBosses) {
				if (FlxG.overlap(i, j)) {
					if (i._kind == j._kind) {
						trace(i._kind, j._kind);
						bossHealth--;
					} else {
						numHearts--;
						if (numHearts == 2) {
							heart3.color = FlxColor.BLACK;
						} else if (numHearts == 1) {
							heart2.color = FlxColor.BLACK;
						} else if (numHearts == 0) {
							heart1.color = FlxColor.BLACK;
							FlxG.switchState(new TextState4());
						}
					}
					i.destroy();
				}
			}
		}
		
		if (count % 30 == 0 && count != 0) {
			if (ran == 0) {
				_boss1.destroy();
				_boss1 = new Boss(num1);
				_boss1.scale.set(1.5, 1.5);
				_boss1.updateHitbox();
				_boss1.x = 300;
				_boss1.y = 200;
				_grpBosses.add(_boss1);
			} else if (ran == 1) {
				_boss2.destroy();
				_boss2 = new Boss(num2);
				_boss2.scale.set(1.5, 1.5);
				_boss2.updateHitbox();
				_boss2.x = 300;
				_boss2.y = 200;
				_grpBosses.add(_boss2);
			} else if (ran == 2) {
				_boss3.destroy();
				_boss3 = new Boss(num3);
				_boss3.scale.set(1.5, 1.5);
				_boss3.updateHitbox();
				_boss3.x = 300;
				_boss3.y = 200;
				_grpBosses.add(_boss3);
			}
			ran = FlxG.random.int(0, 2);
			trace(ran, count);
			if (ran == 0) {
				add(_boss1);
			} else if (ran == 1) {
				add(_boss2);
			} else if (ran == 2) {
				add(_boss3);
			}
		}  else if (count == 0) {
			add(_boss1);
		}
		count++;
		super.update(elapsed);
	}

}