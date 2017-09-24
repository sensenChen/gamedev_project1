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
	
	private var _level:FlxTilemap;
	private var _hud: HUD;

	override public function create():Void
	{	
		super.create();
		var M = 10;
		var N = 10;
		var arr = MazeGeneration.generateMaze(M,N);
		var points:Array<Array<Int> > = [for (x in 0...((2*M-1)*(2*N-1))) [for (y in 0...2) 0]];
		for(i in 0...(2*M-1)) {
			for(j in 0...(2*N-1)) {
				points[i*(2*M-1) +j][0] = i;
				points[i*(2*M-1) +j][1] = j;
			}
		}

		var hearts:Array<Int> = getCenters((2*M-1), (2*N-1), points, 5);
		var enemies:Array<Int> = getCenters((2*M-1), (2*N-1), points, 10);

		// hearts.sort(<);
		// enemies.sort(<);

		// for(i in 0...10) {
    	// 	for(j in 0...5) {
      	// 		if(enemies[i]==hearts[j])
        // 			hearts[j]++;
    	// 	}
  		// }

		for(i in enemies) {
    		var enemyX = points[i][0]+1;
    		var enemyY = points[i][1]+1;
  		}

		for(i in hearts) {
    		var heartX = points[i][0]+1;
    		var hearyY = points[i][1]+1;
  		}	


		for(i in enemies) {
    		var x = points[i][0]+1;
    		var y = points[i][1]+1;
    		var path:Array<Int> = generatePath(display, x, y, 10);
		}



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
		_player.x = 40;
		_player.y = 50;
		_player.updateHitbox();
		_player.health = 1000;
		add(_player);
		
		// enemy
		_enemy = new Enemy();
		_enemy.scale.set(.30, .30);
		_enemy.x = 50;
		_enemy.y = 50;
		_enemy.updateHitbox();
		add(_enemy);
		
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

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(_player, _level);
		FlxG.collide(_enemy, _level);
		FlxG.overlap(_enemy, _player);
		if (FlxCollision.pixelPerfectCheck(_player, _enemy)) {
			_player.health -= 1;
			_hud.updateHUD(_player.health);
		}
		super.update(elapsed);
	}
}