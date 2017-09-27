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
import haxe.Json;
import openfl.Assets;
import flixel.tile.FlxBaseTilemap;
import flixel.util.FlxCollision;
import flixel.util.FlxArrayUtil;
import MazeGeneration.*;
import flixel.system.FlxSound;
import flixel.group.FlxGroup.FlxTypedGroup;
import sys.io.File;

class PlayState3 extends FlxState
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
	var data:PlayState.Config;
	var points:Array<Array<Int> >;
	var hearts:Array<Int>; 
	var enemies:Array<Int>;

	var count:Int;
	var arr:Array<Array<Int> >;
	var epaths:Array<Array<Int> >;
	private var _wall:FlxTilemap;
	private var _background:FlxTilemap;
	private var _hud: HUD;
	var _grpEnemies = new FlxTypedGroup<Enemy>();
	var _grpAttacks:FlxTypedGroup<Attack>;
	
	override public function create():Void
	{	
		super.create();
		count = 0;
		var M = 12;
		var N = 12;
		/* arr = MazeGeneration.generateMaze(M,N);
		epaths = load(M, N); */
		var content:String = sys.io.File.getContent("assets/data/g3.json");
		data = haxe.Json.parse(content);
		
		// music
		var _loop = FlxG.sound.load("assets/music/Theme-2H.wav", 1, true);
		_loop.play();
		
		// add map
		// walls
		_wall = new FlxTilemap();
		_wall.loadMapFrom2DArray(data.dsp, "assets/images/Tiles_64x64x2.png", 64, 64, OFF, 1, 1, 1);
		_wall.scale.set(40 / 64, 40 / 64);
		add(_wall);
		
		for (i in 0...2*M+1) {
			for (j in 0...2*N+1) {
				if (data.dsp[i][j] == 0) {
					data.dsp[i][j] = 1;
				} else if (data.dsp[i][j] == 1){
					data.dsp[i][j] = 0;
				}
			}
		}
		// background
		_background = new FlxTilemap();
		_background.loadMapFrom2DArray(data.dsp, "assets/images/Tiles_64x64x2.png", 64, 64, OFF, 0, 1, 1);
		_background.scale.set(40 / 64, 40 / 64);
		add(_background);
		for (i in 0...2*M+1) {
			for (j in 0...2*N+1) {
				if (data.dsp[i][j] == 0) {
					data.dsp[i][j] = 1;
				} else if (data.dsp[i][j] == 1){
					data.dsp[i][j] = 0;
				}
			}
		} 
		// show heart pieces
		h1 = new FlxSprite(data.heartY[0]*40, data.heartX[0]*40);
		h1.loadGraphic("assets/images/h1.png", false, 64, 64);
		h1.scale.set(40 / 64, 40 / 64);
		h1.updateHitbox();
		add(h1);
		h2 = new FlxSprite(data.heartY[1]*40, data.heartX[1]*40);
		h2.loadGraphic("assets/images/h2.png", false, 64, 64);
		h2.scale.set(40 / 64, 40 / 64);
		h2.updateHitbox();
		add(h2);
		h3 = new FlxSprite(data.heartY[2]*40, data.heartX[2]*40);
		h3.loadGraphic("assets/images/h3.png", false, 64, 64);
		h3.scale.set(40 / 64, 40 / 64);
		h3.updateHitbox();
		add(h3);
		h4 = new FlxSprite(data.heartY[3]*40, data.heartX[3]*40);
		h4.loadGraphic("assets/images/h4.png", false, 64, 64);
		h4.scale.set(40 / 64, 40 / 64);
		h4.updateHitbox();
		add(h4);
		h5 = new FlxSprite(data.heartY[4]*40, data.heartX[4]*40);
		h5.loadGraphic("assets/images/h5.png", false, 64, 64);
		h5.scale.set(40 / 64, 40 / 64);
		h5.updateHitbox();
		add(h5);
		
		// health for keep tracking
		heart1 = new FlxSprite(22*40, 0);
		heart1.loadGraphic("assets/images/heart.png", false);
		heart1.scale.set(40 / 64, 40 / 64);
		heart1.updateHitbox();
		add(heart1);
		heart2 = new FlxSprite(23*40, 0);
		heart2.loadGraphic("assets/images/heart.png", false, 64, 64);
		heart2.scale.set(40 / 64, 40 / 64);
		heart2.updateHitbox();
		add(heart2);
		heart3 = new FlxSprite(24*40, 0);
		heart3.loadGraphic("assets/images/heart.png", false, 64, 64);
		heart3.scale.set(40 / 64, 40 / 64);
		heart3.color = FlxColor.BLACK;
		heart3.updateHitbox();
		add(heart3);
		// add attacks
		_grpAttacks = new FlxTypedGroup<Attack>();
		add(_grpAttacks);

		// player
		_player = new Player(_grpAttacks, false);
		_player.scale.set(32/64, 32/64);
		_player.x = data.playerX * 40;
		_player.y = data.playerY * 40;
		_player.updateHitbox();
		_player.health = 2;
		add(_player);
		
		// enemy
		for (i in 0...10) {
			var newpath = new Array<Int>();
			for (e in 0...10) {
				for (j in 0...10) {
					newpath.push(data.paths[i][e]);
				}
			}
			_enemy = new Enemy(data.enemyY[i]*40, data.enemyX[i]*40, newpath, 2, 40);
			_enemy.scale.set(40/64, 40/64);
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
		//FlxG.collide(_grpEnemies, _wall);
		if (FlxG.overlap(_player, _grpEnemies)) {
			// reset the level
			FlxG.resetState();
		}
		for (i in _grpAttacks) {
			for (j in _grpEnemies) {
				// kill enemies
				if (FlxG.overlap(i, j)) {
					_grpAttacks.remove(i);
					i.destroy();
					j.destroy();
				}
			}
			// attack hit walls
			if (FlxG.collide(i, _wall)) {
				_grpAttacks.remove(i);
				i.destroy();
			}
		}
		if (count == 5) {
			count = 0;
			heart4 = new FlxSprite(24*40, 0);
			heart4.loadGraphic("assets/images/heart.png", false, 64, 64);
			heart4.scale.set(40 / 64, 40 / 64);
			heart4.updateHitbox();
			add(heart4);
			_player.health++;
			_hud.updateHUD(_player.health);
			FlxG.switchState(new BossState());
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

	/* public function load(M:Int, N:Int): Array<Array<Int>>{
		points = [for (x in 0...((2 * M - 1) * (2 * N - 1))) [for (y in 0...2) 0]];
		var paths:Array<Array<Int> > = new Array<Array<Int> >();
		var pathIt = 0;
		
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
			arr[enemyX][enemyY] = 0;
  		}

		for(i in hearts) {
    		var heartX = points[i][0]+1;
    		var heartY = points[i][1] + 1; 
			arr[heartX][heartY] = 0;
			//trace(heartX, heartY);
  		}

		for(i in enemies) {
    		var x = points[i][0]+1;
    		var y = points[i][1]+1;
    		var path:Array<Int> = generatePath(arr, x, y, 10);
			paths[pathIt] = path;
			trace(x, y);
			trace(path);
			pathIt++;
		}
		
		for (a in arr) {
			trace(a);
		}
		// trace(arr);
		return paths;
	} */
}