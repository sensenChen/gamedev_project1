package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;

class Credits extends FlxState
{   
    var text:flixel.text.FlxText;
    var counter:Int = 0;
    

    override public function create():Void
    {
        super.create();
        
        var _loop = FlxG.sound.load("assets/music/Theme-1H.wav", 1, true);
		_loop.play();


        var _cringe1 = FlxG.sound.load("assets/recording/Intro_Clip_1.3.wav", 1, false);
		_cringe1.play();

        text = new flixel.text.FlxText(50, 50, -1, "Art\nClaire Zhu\n\nMusic\nConnor Griffin\n\nWriting\nMaria Salmon\n\nCoding\nMengyi Li\nSensen Chen",16);
        text.screenCenter();
        text.y = 100;
        text.alignment = "center";

        add(text);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        counter++;

        if(FlxG.keys.anyPressed([SPACE])) {
            switchState();
        }
    }

    function switchState() {
        FlxG.switchState(new MenuState());
    }

}