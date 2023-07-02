package funkin.substates;

import sys.io.File;
import sys.FileSystem;
import funkin.game.PlayState;
import flixel.math.FlxMath;
import data.Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<FlxText>;

	var menuItems:Array<String> = [];
	var menuItemsOG:Array<String> = ['Resume', 'Restart Song', 'Change Difficulty', 'Exit to menu'];
	var difficultyChoices = [];
	var curSelected:Int = 0;

	var pauseMusic:FlxSound;
	var practiceText:FlxText;
	var skipTimeText:FlxText;
	var skipTimeTracker:Alphabet;
	var curTime:Float = Math.max(0, Conductor.songPosition);

	var box:FlxSprite;
	var itemMap:Map<Int, FlxText> =
	[
		0 => null,
		1 => null,
		2 => null
	];
	var positions:Array<Float> = [0, 0, 0];
	//var botplayText:FlxText;

	var char1:FlxSprite;
	var char2:FlxSprite;

	public static var songName:String = '';

	public function new(x:Float, y:Float)
	{
		super();

		pauseMusic = new FlxSound();
		if(songName != null) {
			pauseMusic.loadEmbedded(Paths.music(songName), true, true);
		} else if (songName != 'None') {
			pauseMusic.loadEmbedded(Paths.music(Paths.formatToSongPath('tea-time')), true, true);
		}
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		var levelInfo:FlxText = new FlxText(20, 15, 0, "", 32);
		levelInfo.text += funkin.game.PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();
		levelInfo.screenCenter(X);
		add(levelInfo);

		practiceText = new FlxText(20, 15 + 101, 0, "PRACTICE MODE", 32);
		practiceText.scrollFactor.set();
		practiceText.setFormat(Paths.font('vcr.ttf'), 32);
		practiceText.x = FlxG.width - (practiceText.width + 20);
		practiceText.updateHitbox();
		practiceText.visible = funkin.game.PlayState.instance.practiceMode;
		add(practiceText);

		var chartingText:FlxText = new FlxText(20, 15 + 101, 0, "CHARTING MODE", 32);
		chartingText.scrollFactor.set();
		chartingText.setFormat(Paths.font('vcr.ttf'), 32);
		chartingText.x = FlxG.width - (chartingText.width + 20);
		chartingText.y = FlxG.height - (chartingText.height + 20);
		chartingText.updateHitbox();
		chartingText.visible = funkin.game.PlayState.chartingMode;
		add(chartingText);

		box = new FlxSprite(470, 1000, Paths.image('pause/box'));
		box.screenCenter(X);
		box.setGraphicSize(Std.int(box.width * 0.55));
		box.alpha = 0.3;
		add(box);

		itemMap[0] = new FlxText(560, 900, FlxG.width, 'Resume', 30);
		itemMap[0].setFormat(Paths.font('vcr.ttf'), 40, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		add(itemMap[0]);

		itemMap[1] = new FlxText(560, 900, FlxG.width, 'Restart', 30);
		itemMap[1].setFormat(Paths.font('vcr.ttf'), 40, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		add(itemMap[1]);

		itemMap[2] = new FlxText(594, 900, FlxG.width, 'Exit', 30);
		itemMap[2].setFormat(Paths.font('vcr.ttf'), 40, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		add(itemMap[2]);

		var path;
		var path_2;

		switch (PlayState.SONG.song.toLowerCase().replace('-', ' '))
		{
			case 'house for sale' | 'evaporate' | 'sirokou':
				path = 'bf';
				path_2 = 'jerry';

			default: 
				path = 'bf';
				path_2 = 'jammy';
		}

		char1 = new FlxSprite(400, 100).loadGraphic(Paths.image('pause/$path'));
		char1.setGraphicSize(Std.int(char1.width * 0.7));
		add(char1);

		char2 = new FlxSprite(200, 100).loadGraphic(Paths.image('pause/$path_2'));
		char2.setGraphicSize(Std.int(char2.width * 0.7));
		add(char2);

		levelInfo.alpha = 0;

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(box, {y: ((FlxG.height - box.height) / 2), alpha: 1}, 1.5, {ease: FlxEase.bounceOut});
		FlxTween.tween(itemMap[0], {y: (((FlxG.height - itemMap[0].height) / 2)) - 60, alpha: 1}, 1.5, {ease: FlxEase.bounceOut});
		FlxTween.tween(itemMap[1], {y: (((FlxG.height - itemMap[0].height) / 2)) - 10, alpha: 1}, 1.5, {ease: FlxEase.bounceOut});
		FlxTween.tween(itemMap[2], {y: (((FlxG.height - itemMap[0].height) / 2)) + 40, alpha: 1}, 1.5, {ease: FlxEase.bounceOut});
		FlxTween.tween(char1, {x: 750, y: 110}, 0.8, {ease: FlxEase.expoOut});
		FlxTween.tween(char2, {x: -90, y: 100}, 0.8, {ease: FlxEase.expoOut});

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

		changeSelection();
	}

	var holdTime:Float = 0;
	var cantUnpause:Float = 0.1;
	var _elapsed:Float = 0;
	override function update(elapsed:Float)
	{
		cantUnpause -= elapsed;
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		_elapsed = elapsed;

		super.update(elapsed);

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		var daSelected:String = itemMap[curSelected].text;
		switch (daSelected)
		{
			case 'Skip Time':
				if (controls.UI_LEFT_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					curTime -= 1000;
					holdTime = 0;
				}
				if (controls.UI_RIGHT_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					curTime += 1000;
					holdTime = 0;
				}
		}

		if (accepted && (cantUnpause <= 0 || !ClientPrefs.controllerMode))
		{
			if (menuItems == difficultyChoices)
			{
				if(menuItems.length - 1 != curSelected && difficultyChoices.contains(daSelected)) {
					var name:String = funkin.game.PlayState.SONG.song;
					var poop = Highscore.formatSong(name, curSelected);
					funkin.game.PlayState.SONG = Song.loadFromJson(poop, name);
					funkin.game.PlayState.storyDifficulty = curSelected;
					MusicBeatState.resetState();
					FlxG.sound.music.volume = 0;
					funkin.game.PlayState.changedDifficulty = true;
					funkin.game.PlayState.chartingMode = false;
					return;
				}

				menuItems = menuItemsOG;
			}

			switch (daSelected)
			{
				case "Resume":
					close();
				case "Restart":
					restartSong();
				case "Exit":
					funkin.game.PlayState.deathCounter = 0;
					funkin.game.PlayState.seenCutscene = false;

					data.WeekData.loadTheFirstEnabledMod();
					if(funkin.game.PlayState.isStoryMode) {
						MusicBeatState.switchState(new funkin.menus.StoryMenuState());
					} else {
						switch(funkin.game.PlayState.SONG.song.toLowerCase())
						{
							case 'house-for-sale' | 'evaporate' | 'sirokou': 
								MusicBeatState.switchState(new funkin.freeplay.main.Jerry());
							case 'blue' | 'tragical-comedy' | 'shattered':
								MusicBeatState.switchState(new funkin.freeplay.main.Tom());
							case 'funny-cartoon' | 'cat-chase' | 'unstoppable-block':
								MusicBeatState.switchState(new funkin.freeplay.main.WhyDidYallAddPibbyGoddamn());
							default: // ain't gonna do a case for the tons of extras
								MusicBeatState.switchState(new funkin.freeplay.ExtrasState());
						}
					}
					funkin.game.PlayState.cancelMusicFadeTween();
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
					funkin.game.PlayState.changedDifficulty = false;
					funkin.game.PlayState.chartingMode = false;
			}
		}
	}

	public static function restartSong(noTrans:Bool = false)
	{
		funkin.game.PlayState.instance.paused = true; // For lua
		FlxG.sound.music.volume = 0;
		funkin.game.PlayState.instance.vocals.volume = 0;

		if(noTrans)
		{
			FlxTransitionableState.skipNextTransOut = true;
			FlxG.resetState();
		}
		else
		{
			MusicBeatState.resetState();
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		if (curSelected < 0)
			curSelected = 2;
		if (curSelected >= 3)
			curSelected = 0;
		
		itemMap[0].color = (curSelected == 0 ? FlxColor.WHITE: FlxColor.GRAY);
		itemMap[1].color = (curSelected == 1 ? FlxColor.WHITE: FlxColor.GRAY);
		itemMap[2].color = (curSelected == 2 ? FlxColor.WHITE: FlxColor.GRAY);
	}
}
