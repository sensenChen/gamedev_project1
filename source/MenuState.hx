package;

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
        // text.screenCenter();

		var _loop = FlxG.sound.load("assets/music/Theme-4H.wav", 1, true);
		_loop.play();

		_playButton = new FlxButton(300, 310, "Start game", clickPlay);
		// _playButton.screenCenter();

		_creditButton = new FlxButton(300, 330, "Credits", openCredits);

		add(_playButton);
		add(_creditButton);
		add(text);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	function clickPlay():Void
		FlxG.switchState(new TextState());
	}

	function openCredits():Void {
		FlxG.switchState(new Credits());
	}

}
