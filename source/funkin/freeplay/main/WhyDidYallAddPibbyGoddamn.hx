package funkin.freeplay.main;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
#if sys
import sys.io.File;
#end
import flixel.FlxSprite;
import flixel.FlxG;


class WhyDidYallAddPibbyGoddamn extends MusicBeatState
{
	var CanSelect:Bool;

	var SelectAmount:Int = 1;
	var SelectAmountBack:Int = -1;

	var ProductSelected:Int;

	// end my suffering, counting that i have to make it accurate to the script for prevent crashes
	var image:FlxSprite;
	var image1:FlxSprite;
	var image2:FlxSprite;

	var song:FlxSprite;
	var song1:FlxSprite;
	var song2:FlxSprite;

	var bg:FlxSprite;

	var selectedString:String = "house-for-sale";

	var arrow1:FlxSprite;
	var arrow2:FlxSprite;

	var shader:FlxRuntimeShader;

	override function create() 
	{	
		#if desktop
		DiscordClient.changePresence('In the Menus', null);
		#end

		ProductSelected = 0;

		FlxG.camera.zoom = 5;
		FlxTween.tween(FlxG, {'camera.zoom': 1}, 3, {ease: FlxEase.cubeInOut});

		#if sys
		shader = new FlxRuntimeShader(File.getContent('./mods/shaders/monitor.frag'), null, 140);
		if(ClientPrefs.shaders) {
		FlxG.camera.setFilters([new ShaderFilter(shader)]);
		}
		#end

		bg = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay/backBG'));
		bg.screenCenter();
		add(bg);

		arrow1 = new FlxSprite(255, 260).loadGraphic(Paths.image('freeplay/arrow'));
		add(arrow1);

		arrow2 = new FlxSprite(arrow1.x, 430).loadGraphicFromSprite(arrow1);
		arrow2.flipY = true;
		add(arrow2);

		image = new FlxSprite(841, 257).loadGraphic(Paths.image('freeplay/pictures/pibby-tom'));
		image.visible = true;
		add(image);

		image1 = new FlxSprite(841, 257).loadGraphicFromSprite(image);
		image1.visible = false;
		add(image1);

		image2 = new FlxSprite(841, 257).loadGraphicFromSprite(image);
		image2.visible = false;
		add(image2);

		song = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/funny-cartoon'));
		song.visible = true;
		add(song);

		song1 = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/cat-chase'));
		song1.visible = false;
		add(song1);

		song2 = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/unstoppable-block'));
		song2.visible = false;
		add(song2);

		changeSong();

		super.create();
	}

	override function update(elapsed:Float) 
	{
		if(controls.UI_UP_P)
			changeSong(-1);

		if(controls.UI_DOWN_P)
			changeSong(1);

		if(controls.ACCEPT)
			setBeforeStarting();

		if(controls.BACK)
			MusicBeatState.switchState(new funkin.menus.FreeplayCategory());

		super.update(elapsed);
	}

	// more messy stuff 😔
	function changeSong(change:Int = 0) {
		ProductSelected += change;

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.7);

		trace(selectedString);

		switch(ProductSelected)
		{
			case 1:
				image2.visible = false;
				image1.visible = false;
				image.visible = true;
				song.visible = true;
				song1.visible = false;
				song2.visible = false;
				selectedString = "funny-cartoon";

			case 2:
				image.visible = false;
				image1.visible = true;
				image2.visible = false;
				song1.visible = true;
				song.visible = false;
				song2.visible = false;
				selectedString = "cat-chase";

			case 3:
				image1.visible = false;
				image2.visible = true;
				image.visible = false;
				song2.visible = true;
				song.visible = false;
				song1.visible = false;
				selectedString = "unstoppable-block";
		}

      if(ProductSelected >= 3)
			ProductSelected = 3;
		else if(ProductSelected < 1)
			ProductSelected = 1;
	}

	function setBeforeStarting():Void {
		funkin.game.PlayState.SONG = Song.loadFromJson(selectedString+'-hard', selectedString);
		funkin.game.PlayState.isStoryMode = false;
		funkin.game.PlayState.storyDifficulty = 2;

		if (FlxG.keys.pressed.SHIFT){
			LoadingState.loadAndSwitchState(new editors.ChartingState());
			FlxG.sound.music.volume = 0;
		}else{
			startSong(); // smooth transition
		}
	}

	function startSong()
		{
			FlxTween.tween(FlxG.sound.music, {pitch: 0.01}, 1.5);
			FlxTween.tween(FlxG.camera, {alpha: 0}, 3, {ease: FlxEase.expoOut});
			FlxTween.tween(FlxG.camera, {zoom: 3}, 2.7, {ease: FlxEase.cubeInOut});
			new flixel.util.FlxTimer().start(2.5, function(e)
				{
					FlxG.sound.music.volume = 0;
					LoadingState.loadAndSwitchState(new funkin.game.PlayState());
				});
		}
}