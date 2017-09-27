package;

import flixel.FlxG;
import flixel.FlxState;
// import flixel.FlxTextAlign;

class TextState2 extends FlxState
{   
    var text:flixel.text.FlxText;
    var counter:Int = 0;
    

    override public function create():Void
    {
        super.create();
        
        var _loop = FlxG.sound.load("assets/music/Theme-1H.wav", 1, true);
		_loop.play();


        var _cringe1 = FlxG.sound.load("assets/recording/Before_Boss_1.1.wav", 1, false);
		_cringe1.play();

        text = new flixel.text.FlxText(50, 50, 500, "Oh, you poor unlovable creature...You’re so close! But, as of course you know, the last person standing in your way - is you!", 19);
        text.screenCenter();
        text.y = 100;
        add(text);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        counter++;

        if(counter==800) {
            switchState();
        }
    }

    function switchState() {
        FlxG.switchState(new BossState());
    }

}