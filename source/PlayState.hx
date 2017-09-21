package;

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
import MazeGeneration.*;

class PlayState extends FlxState
{
	var _player:Player;
	var enemy:FlxSprite;
	private var _level:FlxTilemap;
	private var hud: HUD;
	override public function create():Void
	{
		super.create();
		var arr = MazeGeneration.generateMaze(10,10);
		// add map
		_level = new FlxTilemap();
		_level.loadMapFrom2DArray(arr, "assets/images/Tiles.png", 20, 20, AUTO);
		// _level.loadMapFromCSV("assets/data/test.csv", "assets/images/Tiles.png", 20, 20, AUTO);
		_level.scale.set(2, 2);
		add(_level);
		
		// player
		_player = new Player();
		_player.scale.set(.30, .30);
		_player.x = 40;
		_player.y = 50;
		_player.updateHitbox();
		add(_player);
		
		// test enemy
		/*enemy = new FlxSprite();
		enemy.makeGraphic(200, 200, FlxColor.WHITE);
		enemy.immovable = true;
		enemy.solid = true;
		enemy.x = 100;
		enemy.y = 300;
		enemy.updateHitbox();
		add(enemy);*/
		
		// health bar
		hud = new HUD(_player);
		add(hud);
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide();
		super.update(elapsed);
	}
}