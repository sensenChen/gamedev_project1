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
import flixel.util.FlxCollision;
import flixel.util.FlxArrayUtil;
import MazeGeneration.*;
class PlayState extends FlxState
{
	var _player:Player;
	var _enemy:Enemy;
	var h1:FlxSprite;
	var h2:FlxSprite;
	var h3:FlxSprite;
	var h4:FlxSprite;
	var h5:FlxSprite;
	var heart:FlxSprite;

	var points:Array<Array<Int> >;
	var hearts:Array<Int>; 
	var enemies:Array<Int>;


	var arr:Array<Array<Int> >;
	private var _level:FlxTilemap;
	private var _hud: HUD;

	

	override public function create():Void
	{	
		super.create();

		var M = 10;
		var N = 10;
		var arr = MazeGeneration.generateMaze(M,N);
		//load(M,N);


		// add map
		_level = new FlxTilemap();
		_level.loadMapFrom2DArray(arr, "assets/images/Tiles.png", 20, 20, AUTO);
		// _level.loadMapFromCSV("assets/data/test.csv", "assets/images/Tiles.png", 20, 20, AUTO);
		_level.scale.set(2, 2);
		add(_level);
		// show heart
		h1 = new FlxSprite(500, 100);
		h1.loadGraphic("assets/images/h1.png", false, 64, 64);
		add(h1);
		h2 = new FlxSprite(570, 100);
		h2.loadGraphic("assets/images/h2.png", false, 64, 64);
		add(h2);
		h3 = new FlxSprite(640, 100);
		h3.loadGraphic("assets/images/h3.png", false, 64, 64);
		add(h3);
		h4 = new FlxSprite(710, 100);
		h4.loadGraphic("assets/images/h4.png", false, 64, 64);
		add(h4);
		h5 = new FlxSprite(780, 100);
		h5.loadGraphic("assets/images/h5.png", false, 64, 64);
		add(h5);
		
		// player
		_player = new Player();
		_player.scale.set(.30, .30);
		_player.x = 420;
		_player.y = 420;
		_player.updateHitbox();
		_player.health = 1000;
		add(_player);
		
		// enemy
		_enemy = new Enemy(40, 40);
		_enemy.scale.set(.30, .30);
		_enemy.updateHitbox();
		add(_enemy);
		/*var path = new Array<Int>();
		path = [0, 1, 2, 3];
		_enemy = new Enemy(250, 250, path);
		_enemy.scale.set(.30, .30);
		_enemy.immovable = true;
		_enemy.updateHitbox();
		
		add(_enemy);*/
		
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
		_hud = new HUD(_player);
		add(_hud);
	}

	// [111333] move along the path
	// group 
	
	override public function update(elapsed:Float):Void
	{
		FlxG.collide(_player, _level);
		FlxG.collide(_enemy, _level);
		if (FlxG.overlap(_player, _enemy)) {
			// reset the level
			FlxG.resetState();
		}
		super.update(elapsed);
	}

	function load(M:Int, N:Int):Void {
		points = [for (x in 0...((2*M-1)*(2*N-1))) [for (y in 0...2) 0]];
		for(i in 0...(2*M-1)) {
			for(j in 0...(2*N-1)) {
				points[i*(2*M-1) +j][0] = i;
				points[i*(2*M-1) +j][1] = j;
			}
		}

		hearts = getCenters((2*M-1), (2*N-1), points, 5);
		enemies = getCenters((2*M-1), (2*N-1), points, 10);

		for(i in enemies) {
    		var enemyX = points[i][0]+1;
    		var enemyY = points[i][1]+1;
  		}

		for(i in hearts) {
    		var heartX = points[i][0]+1;
    		var heartY = points[i][1]+1;
  		}	

		for(i in enemies) {
    		var x = points[i][0]+1;
    		var y = points[i][1]+1;
    		var path:Array<Int> = generatePath(display, x, y, 10);
			// trace(path);
		}
	}

}