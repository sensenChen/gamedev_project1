package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;

class MenuState extends FlxState
{
	var _playButton:FlxButton;
	var _creditButton:FlxButton;
	
	override public function create():Void
	{
		super.create();
		var text = new flixel.text.FlxText(125, 100, -1, "HeartFelt", 64);
		text.x -= 50;
		text.y += 100;
        // text.screenCenter();
		var titleArt = new FlxSprite(100, 100);
		titleArt.loadGraphic("assets/images/Title Art.png", false);
		titleArt.scale.set(.45, .45);
		titleArt.screenCenter();
		titleArt.y -= 100;
		titleArt.x += 200;
		add(titleArt);
		
		var _loop = FlxG.sound.load("assets/music/Theme-4H.wav", 1, true);
		_loop.play();

		_playButton = new FlxButton(0, 0, "Start game", clickPlay);
		_creditButton = new FlxButton(0, 0, "Credits", openCredits);
		_playButton.screenCenter();
		_creditButton.screenCenter();
		_creditButton.y = 380;
		_playButton.y += 50;

		add(_playButton);
		add(_creditButton);
		add(text);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	function clickPlay():Void {
		FlxG.switchState(new TextState());
	}

	function openCredits():Void {
		FlxG.switchState(new Credits());
	}
}
