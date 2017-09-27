package;

import flixel.FlxG;
import flixel.FlxState;
// import flixel.FlxTextAlign;

class TextState3 extends FlxState
{   
    var text:flixel.text.FlxText;
    var counter:Int = 0;
    

    override public function create():Void
    {
        super.create();
        
        var _loop = FlxG.sound.load("assets/music/Theme-5H.wav", 1, true);
		_loop.play();


        var _cringe1 = FlxG.sound.load("assets/recording/Win_1.3.wav", 1, false);
		_cringe1.play();

        text = new flixel.text.FlxText(50, 50, 500, "Ah! What a happy day! What a happy occasion! Oh, it’s so pleasing to finally see someone do it...I swear you are the first one in eons to make it through!
", 19);
        text.screenCenter();
        add(text);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        counter++;

        if(counter==750) {
            text.text = "Well, you’ve certainly earned this!";
             var _cringe1 = FlxG.sound.load("assets/recording/Win_2.3.wav", 1, false);
		    _cringe1.play();
        } else if(counter==850) {
             text.text = "Treat it well. I rather doubt that you want to do all this again...";
        } else if(counter==1100) {
            text.text = "And, if you can manage it, please keep in mind that while seduction can be a perfectly wonderful thing - just make sure you don’t catch anything, and that your dear seductor doesn’t take anything.";
            var _cringe1 = FlxG.sound.load("assets/recording/Win_3.3.wav", 1, false);
		    _cringe1.play();
        } else if(counter>=1700) {
            text.text = "Watch over your heart. \n\n Press SPACE to Continue";
            if(FlxG.keys.anyPressed([SPACE])) {
                switchState();
            }
        }
    }

    function switchState() {
        FlxG.switchState(new MenuState());
    }

}