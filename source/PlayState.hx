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
class PlayState extends FlxState
{
	var _player:Player;
	var _enemy:Enemy;
	var h1:FlxSprite;
	var h2:FlxSprite;
	var h3:FlxSprite;
	var h4:FlxSprite;
	var h5:FlxSprite;
	var heart1:FlxSprite;
	var heart2:FlxSprite;
	var heart3:FlxSprite;
	var heart4:FlxSprite;
	
	var points:Array<Array<Int> >;
	var hearts:Array<Int>; 
	var enemies:Array<Int>;

	var count:Int;
	var arr:Array<Array<Int> >;
	private var _wall:FlxTilemap;
	private var _background:FlxTilemap;
	private var _hud: HUD;
	var _grpEnemies = new FlxTypedGroup<Enemy>();
	
	override public function create():Void
	{	
		super.create();
		count = 0;
		var M = 10;
		var N = 10;
		var arr = MazeGeneration.generateMaze(M,N);
		load(M, N);
		
		// add map
		// walls
		_wall = new FlxTilemap();
		_wall.loadMapFrom2DArray(arr, "assets/images/Tiles_64x64x2.png", 64, 64, OFF, 1, 1, 1);
		_wall.scale.set(40 / 64, 40 / 64);
		add(_wall);
		for (i in 0...2*M+1) {
			for (j in 0...2*N+1) {
				if (arr[i][j] == 0) {
					arr[i][j] = 1;
				} else if (arr[i][j] == 1){
					arr[i][j] = 0;
				}
			}
		}
		// background
		_background = new FlxTilemap();
		_background.loadMapFrom2DArray(arr, "assets/images/Tiles_64x64x2.png", 64, 64, OFF, 0, 1, 1);
		_background.scale.set(40 / 64, 40 / 64);
		add(_background);
		for (i in 0...2*M+1) {
			for (j in 0...2*N+1) {
				if (arr[i][j] == 0) {
					arr[i][j] = 1;
				} else if (arr[i][j] == 1){
					arr[i][j] = 0;
				}
			}
		}
		// show heart pieces
		h1 = new FlxSprite(points[hearts[0]][0]*40, points[hearts[0]][1]*40);
		h1.loadGraphic("assets/images/h1.png", false, 64, 64);
		h1.scale.set(40 / 64, 40 / 64);
		h1.updateHitbox();
		add(h1);
		h2 = new FlxSprite(points[hearts[1]][0]*40, points[hearts[1]][1]*40);
		h2.loadGraphic("assets/images/h2.png", false, 64, 64);
		h2.scale.set(40 / 64, 40 / 64);
		h2.updateHitbox();
		add(h2);
		h3 = new FlxSprite(points[hearts[2]][0]*40, points[hearts[2]][1]*40);
		h3.loadGraphic("assets/images/h3.png", false, 64, 64);
		h3.scale.set(40 / 64, 40 / 64);
		h3.updateHitbox();
		add(h3);
		h4 = new FlxSprite(points[hearts[3]][0]*40, points[hearts[3]][1]*40);
		h4.loadGraphic("assets/images/h4.png", false, 64, 64);
		h4.scale.set(40 / 64, 40 / 64);
		h4.updateHitbox();
		add(h4);
		h5 = new FlxSprite(points[hearts[4]][0]*40, points[hearts[4]][1]*40);
		h5.loadGraphic("assets/images/h5.png", false, 64, 64);
		h5.scale.set(40 / 64, 40 / 64);
		h5.updateHitbox();
		add(h5);
		
		// health for keep tracking
		heart1 = new FlxSprite(18*40, 0);
		heart1.loadGraphic("assets/images/heart.png", false, 64, 64);
		heart1.scale.set(40 / 64, 40 / 64);
		heart1.color = FlxColor.BLACK;
		heart1.updateHitbox();
		add(heart1);
		heart2 = new FlxSprite(19*40, 0);
		heart2.loadGraphic("assets/images/heart.png", false, 64, 64);
		heart2.scale.set(40 / 64, 40 / 64);
		heart2.color = FlxColor.BLACK;
		heart2.updateHitbox();
		add(heart2);
		heart3 = new FlxSprite(20*40, 0);
		heart3.loadGraphic("assets/images/heart.png", false, 64, 64);
		heart3.scale.set(40 / 64, 40 / 64);
		heart3.color = FlxColor.BLACK;
		heart3.updateHitbox();
		add(heart3);
		
		// player
		_player = new Player();
		_player.scale.set(.30, .30);
		_player.x = 420;
		_player.y = 420;
		_player.updateHitbox();
		_player.health = 0;
		add(_player);
		
		// enemy
		for (i in enemies) {
			_enemy = new Enemy(points[i][0]*40, points[i][1]*40);
			_enemy.scale.set(.30, .30);
			_enemy.updateHitbox();
			add(_enemy);
			_grpEnemies.add(_enemy);
		}
		// health bar
		_hud = new HUD(_player);
		add(_hud);
	}
	
	override public function update(elapsed:Float):Void
	{
		FlxG.collide(_player, _wall);
		FlxG.collide(_grpEnemies, _wall);
		if (FlxG.overlap(_player, _grpEnemies)) {
			// reset the level
			FlxG.resetState();
		}
		if (count == 2) {
			count = 0;
			heart4 = new FlxSprite(18*40, 0);
			heart4.loadGraphic("assets/images/heart.png", false, 64, 64);
			heart4.scale.set(40 / 64, 40 / 64);
			heart4.updateHitbox();
			add(heart4);
			_player.health++;
			_hud.updateHUD(_player.health);
		}
		if (FlxG.overlap(_player, h1)) {
			count++;
			h1.destroy();
		}
		if (FlxG.overlap(_player, h2)) {
			count++;
			h2.destroy();
		}
		if (FlxG.overlap(_player, h3)) {
			count++;
			h3.destroy();
		}
		if (FlxG.overlap(_player, h4)) {
			count++;
			h4.destroy();
		}
		if (FlxG.overlap(_player, h5)) {
			count++;
			h5.destroy();
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