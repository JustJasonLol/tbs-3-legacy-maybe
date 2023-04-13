package funkin.game;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxBasic;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class InvadeEvents extends FlxTypedGroup<Dynamic>
{
    public static var instance:InvadeEvents;

    var text:FlxText;

    public function new()
        {
            super();
        }

    public function createObjects():InvadeEvents
        {
            instance = this;

            text = new FlxText(0, FlxG.height * 0.68, 0, '', 39);
            text.setFormat(Paths.font('fnf_vcr.ttf'), 39, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
            text.cameras = [PlayState.instance.camOther];
            text.screenCenter(X);
            text.x -= 60;
            add(text);

            PlayState.instance.camGame.fade(FlxColor.BLACK, 0.001);

            PlayState.instance.dad.alpha = 0;
            PlayState.instance.iconP2.alpha = 0;

            return this;
        }

    public function beatHitEvents(curBeat:Int):InvadeEvents
        {
            if((curBeat > 112 && curBeat < 176) || (curBeat > 240 && curBeat < 368))
                {
                    PlayState.instance.triggerEventNote('Add Camera Zoom', '', '');
                }

            switch (curBeat)
            {
                case 16:
                    PlayState.instance.camGame.fade(FlxColor.BLACK, 9, true);
            }
            return this;
        }

    private function setText(string:String, ?isMinus:Bool = true, ?xMove:Int = 0):String
        {
            text.x = (isMinus ? text.x-xMove : text.x+xMove);
            return text.text = string;
        }
}