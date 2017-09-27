package;

import flixel.FlxG;
import flixel.FlxState;
// import flixel.FlxTextAlign;

class TextState4 extends FlxState
{   
    var text:flixel.text.FlxText;
    var counter:Int = 0;
    

    override public function create():Void
    {
        super.create();
        
        var _loop = FlxG.sound.load("assets/music/Theme-1H.wav", 1, true);
		_loop.play();


        var _cringe1 = FlxG.sound.load("assets/recording/Fail_1.3.wav", 1, false);
		_cringe1.play();

        text = new flixel.text.FlxText(50, 50, 500, "Well...sometimes when you take a chance...it doesn’t always work out in your favor.", 19);
        text.screenCenter();
        add(text);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        counter++;

        if(counter==400) {
            text.text = "I must say, you put up a valiant fight - I’m rather sad to have to say this.";
            // text.FlxTextAlign = "center";
             var _cringe1 = FlxG.sound.load("assets/recording/Fail_2.3.wav", 1, false);
		    _cringe1.play();

        } else if(counter==700) {
            text.text = "You have lost your heart. You can neither love nor be loved. You are destined to an eternity in this world devoid of affection.";
            // text.FlxTextAlign = "center";
            var _cringe1 = FlxG.sound.load("assets/recording/Fail_3.3.wav", 1, false);
		    _cringe1.play();
        } else if(counter==1200) {
            text.text = "I’m sorry. \n\nPress SPACE to Continue";
            if(FlxG.keys.anyPressed([SPACE])) {
                switchState();
            }
        }
    }

    function switchState() {
        FlxG.switchState(new MenuState());
    }

}