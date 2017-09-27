package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxTextAlign;

class TextState extends FlxState
{   
    var text:flixel.text.FlxText;
    var counter:Int = 0;
    

    override public function create():Void
    {
        super.create();

        text = new flixel.text.FlxText(50, 50, 500, "Seduction...Oh, you poor dear...Seduction is a dangerous thing. If not treated carefully, it can be most dreadful, most detrimental, perhaps - oh yes, perhaps even beyond repair.", 19);
        text.screenCenter();
        add(text);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        counter++;

        if(counter==300) {
            text.text = "Seduction truly is a cruel mistress. Or...maybe it is your mistress that is cruel...as..as well as seductive! Oh...W-wait that’s...that’s just a dominatrix...Moving on!";
            text.FlxTextAlign = "center";
        } else if(counter==600) {
            text.text = "You. Your heart was broken. Your precious heart shattered and those 5 pieces lie abandoned. You were seduced and destroyed, but there is hope for you yet, poor soul. In this home of lost love, you may collect those 5 pieces - seduce those who hold your heart from you - and you will be able to love again.";
            text.FlxTextAlign = "center";
        } else if(counter==900) {
            text.text = "But if you should fail…";
            text.FlxTextAlign = "center";
        } else if(counter==1000) {
            text.text = "Instuctions blah blah instructions...";
            text.FlxTextAlign = "center";
        } else if(counter==1200) {
            FlxG.switchState(new PlayState());
        }


    }
}