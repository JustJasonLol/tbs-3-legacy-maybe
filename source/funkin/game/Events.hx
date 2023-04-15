package funkin.game;

import sys.io.File;
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

    var blackSprite:FlxSprite;

    var multipler:Float = 1;

    var text:FlxText;

    var healthDrain:Bool = false;

    public static var coolShader:FlxRuntimeShader;

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

            blackSprite = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.BLACK);
            blackSprite.screenCenter();
            blackSprite.alpha = 0;
            PlayState.instance.addBehindGF(blackSprite);

            PlayState.instance.camGame.fade(FlxColor.BLACK, 0.001);
            PlayState.instance.camHUD.alpha = 0;

            PlayState.instance.dad.alpha = 0;
            PlayState.instance.iconP2.alpha = 0;

            PlayState.instance.camZooming = true;

            coolShader = new FlxRuntimeShader(File.getContent('./mods/shaders/aberration.frag'), null, 140);

            return this;
        }

    public function beatHitEvents(curBeat:Int):InvadeEvents
        {   
            if((curBeat > 72 && curBeat < 104) || (curBeat > 112 && curBeat < 176) || (curBeat > 240 && curBeat < 368))
                {
                    PlayState.instance.triggerEventNote('Add Camera Zoom', '', '');
                }

            switch (curBeat)
            {
                case 1: 
                    PlayState.instance.songLength = 40 * 1000;
                    PlayState.instance.opponentStrums.forEach(strum->strum.alpha = 0);

                case 16:
                    PlayState.instance.camGame.fade(FlxColor.BLACK, 9, true);

                case 24: 
                    FlxTween.tween(PlayState.instance.camHUD, {alpha: 1}, 4, {ease: FlxEase.sineInOut});

                case 36 | 40 | 44: 
                    PlayState.instance.defaultCamZoom += 0.1;

                case 48: 
                    FlxTween.tween(PlayState.instance.camHUD, {alpha: 0}, 4, {ease: FlxEase.cubeInOut});
                    FlxTween.tween(FlxG.camera, {zoom: 0.9}, 6, {ease: FlxEase.sineInOut, onComplete: meWhenAliensInvadeMyHouse -> PlayState.instance.defaultCamZoom = 0.9});
                    PlayState.instance.camGame.fade(FlxColor.BLACK, 4);

                case 72: 
                    PlayState.instance.iconP2.alpha = 1;
                    PlayState.instance.dad.alpha = 1;
                    PlayState.instance.camGame.fade(FlxColor.BLACK, 0.001, true);
                    PlayState.instance.camHUD.alpha = 1;
                    PlayState.instance.songLength = FlxG.sound.music.length;
                    PlayState.instance.health = 1;
                    PlayState.instance.songMisses = 0;
                    PlayState.instance.songScore = 0;
                    PlayState.instance.ratingPercent = 0;
                    PlayState.instance.RecalculateRating();
                    coolShader.setFloat('aberration', 0.05);
                    coolShader.setFloat('effectTime', 0.05); // this one is needed apparently


                case 104: 
                    FlxTween.tween(PlayState.instance.camHUD, {alpha: 0}, 1, {ease: FlxEase.sineInOut});

                case 111: 
                    PlayState.instance.defaultCamZoom = 1.4;

                case 112:
                    PlayState.instance.health = 1;
                    FlxTween.tween(PlayState.instance.camHUD, {alpha: 1}, 1, {ease: FlxEase.sineInOut});
                    PlayState.instance.songMisses = 0;
                    PlayState.instance.songScore = 0;
                    PlayState.instance.ratingPercent = 0;
                    PlayState.instance.RecalculateRating();
                    PlayState.instance.defaultCamZoom = 0.9;
                
                case 176: 
                    PlayState.instance.defaultCamZoom = 1.2;
                    FlxTween.tween(blackSprite, {alpha: 0.85}, 0.7, {ease: FlxEase.cubeInOut});
                    FlxTween.tween(PlayState.instance.gf, {alpha: 0.2}, 0.7, {ease: FlxEase.cubeInOut});
                    coolShader.setFloat('aberration', 0.1);
                    coolShader.setFloat('effectTime', 0.1);

                case 240:
                    PlayState.instance.defaultCamZoom = 0.9;
                    FlxTween.tween(blackSprite, {alpha: 0}, 0.7, {ease: FlxEase.cubeInOut});
                    FlxTween.tween(PlayState.instance.gf, {alpha: 1}, 0.7, {ease: FlxEase.cubeInOut});
                    coolShader.setFloat('aberration', 0.18);
                    coolShader.setFloat('effectTime', 0.18);
                    healthDrain = true;

                case 367: 
                    healthDrain = false;

                case 401:
                    PlayState.instance.camGame.fade(FlxColor.BLACK, 1.5);
                    FlxTween.tween(PlayState.instance.camHUD, {alpha: 0}, 3.7, {ease: FlxEase.sineInOut});
            }

            if(healthDrain)
                PlayState.instance.health -= 0.026 * multipler;

            if(healthDrain && curBeat % 5 == 0)
                multipler += 0.1;

            return this;
        }

    public function stepHitEvents(curStep:Int):InvadeEvents
        {
            return this;
        }

    private function setText(string:String, ?xMove:Int = 0, ?isMinus:Bool = true):String
        {
            text.x = (isMinus ? text.x-xMove : text.x+xMove);
            return text.text = string;
        }
}