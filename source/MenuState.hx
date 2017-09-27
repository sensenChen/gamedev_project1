package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;

class MenuState extends FlxState
{
	var _playButton:FlxButton;
	
	override public function create():Void
	{
		super.create();

		var text = new flixel.text.FlxText(125, 100, -1, "HeartFelt", 64);
        // text.screenCenter();

		var _loop = FlxG.sound.load("assets/music/Theme-4H.wav", 1, true);
		_loop.play();

		_playButton = new FlxButton(10, 10, "Start game", clickPlay);
		_playButton.screenCenter();
		add(_playButton);
		add(text);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	function clickPlay():Void
	{

		FlxG.switchState(new TextState());
	}
}
