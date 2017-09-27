package;

import flixel.FlxG;
import flixel.FlxState;
// import flixel.FlxTextAlign;

class TextState extends FlxState
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

        text = new flixel.text.FlxText(50, 50, 500, "Seduction...Oh, you poor dear...Seduction is a dangerous thing. If not treated carefully, it can be most dreadful, most detrimental, perhaps - oh yes, perhaps even beyond repair.", 19);
        text.screenCenter();
        text.alignment = "center";
        add(text);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        counter++;
        if(FlxG.keys.anyPressed([SPACE]) && counter<850) {
            counter = 845;
        }

        if(counter>=850 && counter<1700) {
            text.text = "Seduction truly is a cruel mistress. Or...maybe it is your mistress that is cruel...as..as well as seductive! Oh...W-wait that’s...that’s just a dominatrix...Moving on!";
            // text.FlxTextAlign = "center";
            var _cringe1 = FlxG.sound.load("assets/recording/Intro_Clip_2.3.wav", 1, false);
            if(counter==850)
		        _cringe1.play();
            if(FlxG.keys.anyPressed([SPACE]))
                counter = 1695;
            
        } else if(counter>=1700 && counter<3000) {
            text.y = 150;
            text.text = "You. Your heart was broken. Your precious heart shattered and those 5 pieces lie abandoned. You were seduced and destroyed, but there is hope for you yet, poor soul. In this home of lost love, you may collect those 5 pieces - seduce those who hold your heart from you - and you will be able to love again.";
            // text.FlxTextAlign = "center";
            var _cringe1 = FlxG.sound.load("assets/recording/Intro_Clip_3.3.wav", 1, false);
            if(counter==1700)
		        _cringe1.play();
            if(FlxG.keys.anyPressed([SPACE])) {
                counter = 2995;
            }
        } else if(counter>=3000 && counter<3200) {
            text.text = "But if you should fail...";
            // text.FlxTextAlign = "center";

        } else if(counter>=3200) {
            text.y = 150;
            text.text = "MOVEMENT: WASD OR ARROW KEYS\n\nATTACK (Different enemies need different attacks!): \n1 - Kissy lips: Deals Yellow Damage\n2 - Rockette Rocket Leg (RRL): Deals Pink Damage\n3 - Heres My Underwear : Deals Blue Damage\n\n Press SPACE to Continue";
            // text.FlxTextAlign = "center";
            if(FlxG.keys.anyPressed([SPACE])) {
                switchState();
            }
        }
    }

    function switchState() {
        FlxG.switchState(new PlayState());
    }

}