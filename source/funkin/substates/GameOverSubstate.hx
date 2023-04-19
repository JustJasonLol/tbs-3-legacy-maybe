package funkin.substates;

import sys.io.File;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class GameOverSubstate extends MusicBeatSubstate
{
	public var boyfriend:Boyfriend;
	var camFollow:FlxPoint;
	var camFollowPos:FlxObject;
	var updateCamera:Bool = false;
	var playingDeathSound:Bool = false;

	var stageSuffix:String = "";

	public static var characterName:String = 'bf-dead';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';

	var aberration:FlxRuntimeShader;

	public static var instance:GameOverSubstate;

	public static function resetVariables() {
		characterName = 'bf-dead';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';
	}

	override function create()
	{
		instance = this;
		funkin.game.PlayState.instance.callOnLuas('onGameOverStart', []);

		super.create();
	}

	public function new(x:Float, y:Float, camX:Float, camY:Float)
	{
		super();

		funkin.game.PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;

		boyfriend = new Boyfriend(x, y, characterName);
		boyfriend.x += boyfriend.positionArray[0];
		boyfriend.y += boyfriend.positionArray[1];
		add(boyfriend);

		camFollow = new FlxPoint(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);

		FlxG.sound.play(Paths.sound(deathSoundName));
		Conductor.changeBPM(135);
		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		var bloom = new FlxRuntimeShader(File.getContent('./mods/shaders/bloom.frag'), null, 140);
		var monitor = new FlxRuntimeShader(File.getContent('./mods/shaders/monitor.frag'), null, 140);
		aberration = new FlxRuntimeShader(File.getContent('./mods/shaders/aberration.frag'), null, 140);
		aberration.setFloat('aberration', 0.5);
		aberration.setFloat('effectTime', 0.05);

		if(ClientPrefs.shaders)
			{
				FlxG.camera.setFilters([
					new ShaderFilter(monitor),
					new ShaderFilter(bloom),
					new ShaderFilter(aberration),
				]);
			}

		boyfriend.playAnim('firstDeath');

		camFollowPos = new FlxObject(0, 0, 1, 1);
		camFollowPos.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxG.camera.scroll.y + (FlxG.camera.height / 2));
		add(camFollowPos);
	}

	var isFollowingAlready:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		funkin.game.PlayState.instance.callOnLuas('onUpdate', [elapsed]);
		if(updateCamera) {
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 0.6, 0, 1);
			camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
		}

		if (controls.ACCEPT)
		{
			endBullshit();
			aberration.setFloat('effectTime', 0.4);
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			funkin.game.PlayState.deathCounter = 0;
			funkin.game.PlayState.seenCutscene = false;
			funkin.game.PlayState.chartingMode = false;

			WeekData.loadTheFirstEnabledMod();
			if (funkin.game.PlayState.isStoryMode)
				MusicBeatState.switchState(new funkin.menus.StoryMenuState());
			else
				switch(funkin.game.PlayState.SONG.song.toLowerCase())
				{
					case 'house-for-sale' | 'vanishing' | 'sirokou': 
						MusicBeatState.switchState(new funkin.freeplay.main.Jerry());
					case 'blue' | 'tragical-comedy' | 'shattered':
						MusicBeatState.switchState(new funkin.freeplay.main.Tom());
					case 'funny-cartoon' | 'cat-chase' | 'unstoppable-block':
						MusicBeatState.switchState(new funkin.freeplay.main.WhyDidYallAddPibbyGoddamn());
					default: // ain't gonna do a case for the tons of extras
						MusicBeatState.switchState(new funkin.freeplay.ExtrasState());
				}

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			funkin.game.PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
		}

		if (boyfriend.animation.curAnim != null && boyfriend.animation.curAnim.name == 'firstDeath')
		{
			if(boyfriend.animation.curAnim.curFrame >= 12 && !isFollowingAlready)
			{
				FlxG.camera.follow(camFollowPos, LOCKON, 1);
				updateCamera = true;
				isFollowingAlready = true;
			}

			if (boyfriend.animation.curAnim.finished && !playingDeathSound)
			{
				if (funkin.game.PlayState.SONG.stage == 'tank')
				{
					playingDeathSound = true;
					coolStartDeath(0.2);
					
					var exclude:Array<Int> = [];
					//if(!ClientPrefs.cursing) exclude = [1, 3, 8, 13, 17, 21];

					FlxG.sound.play(Paths.sound('jeffGameover/jeffGameover-' + FlxG.random.int(1, 25, exclude)), 1, false, null, true, function() {
						if(!isEnding)
						{
							FlxG.sound.music.fadeIn(0.2, 1, 4);
						}
					});
				}
				else
				{
					coolStartDeath();
				}
				boyfriend.startedDeath = true;
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		funkin.game.PlayState.instance.callOnLuas('onUpdatePost', [elapsed]);

		FlxG.camera.zoom = FlxMath.lerp(1, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
	}

	override function beatHit()
	{
		super.beatHit();

		if(!isEnding && curBeat % 2 == 0)
			{
				FlxG.camera.zoom += 0.065;
			}
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			boyfriend.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music(endSoundName));
			FlxTween.tween(FlxG.camera, {zoom: 2.5}, 9, {ease: FlxEase.cubeInOut});
			new FlxTimer().start(2.5, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 3.4, false, function()
				{
					new FlxTimer().start(0.4, e -> MusicBeatState.resetState());
				});
			});
			funkin.game.PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}
}
