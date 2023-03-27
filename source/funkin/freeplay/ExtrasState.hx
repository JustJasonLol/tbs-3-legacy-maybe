package funkin.freeplay;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
#if sys
import sys.io.File;
#end
import flixel.FlxSprite;
import flixel.FlxG;
#if desktop
import Discord.DiscordClient;
#end

/**
 * messy code is for good
 */
class ExtrasState extends MusicBeatState
{
	var CanSelect:Bool;

	var SelectAmount:Int = 1;
	var SelectAmountBack:Int = -1;

	var ProductSelected:Int;

	// end my suffering, counting that i have to make it accurate to the script for prevent crashes
	var image:FlxSprite;
	var image1:FlxSprite;
	var image2:FlxSprite;
	var image3:FlxSprite;
	var image4:FlxSprite;
	var image5:FlxSprite;
	var image6:FlxSprite;
	var image7:FlxSprite;
	var image8:FlxSprite;
	var image9:FlxSprite;
	var image10:FlxSprite;

	var song:FlxSprite;
	var song1:FlxSprite;
	var song2:FlxSprite;
	var song3:FlxSprite;
	var song4:FlxSprite;
	var song5:FlxSprite;
	var song6:FlxSprite;
	var song7:FlxSprite;
	var song8:FlxSprite;
	var song9:FlxSprite;
	var song10:FlxSprite;

	var bg:FlxSprite;

	var selectedString:String = "come-for-revenge";

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

		image = new FlxSprite(841, 257).loadGraphic(Paths.image('freeplay/pictures/come-for-revenge'));
		image.visible = true;
		add(image);

		image1 = new FlxSprite(841, 257).loadGraphic(Paths.image('freeplay/pictures/come-for-revenge'));
		image1.visible = false;
		add(image1);

		image2 = new FlxSprite(841, 257).loadGraphic(Paths.image('freeplay/pictures/DOJ'));
		image2.visible = false;
		add(image2);

		image3 = new FlxSprite(841, 257).loadGraphic(Paths.image('freeplay/pictures/invade'));
		image3.visible = false;
		add(image3);

		image4 = new FlxSprite(841, 257).loadGraphic(Paths.image('freeplay/pictures/jam'));
		image4.visible = false;
		add(image4);

		image5 = new FlxSprite(841, 257).loadGraphic(Paths.image('freeplay/pictures/lightning'));
		image5.visible = false;
		add(image5);

		image6 = new FlxSprite(841, 257);
		image6.frames = Paths.getSparrowAtlas('freeplay/pictures/meme_mouse/meme_mouse_${FlxG.random.int(1, 5)}');
		image6.animation.addByPrefix('idle', 'idle', 65);
		image6.setGraphicSize(Std.int(image6.width * 1.5));
		image6.animation.play('idle');
		image6.visible = false;
		add(image6);

		image7 = new FlxSprite(841, 257).loadGraphic(Paths.image('freeplay/pictures/mucho mouse'));
		image7.visible = false;
		add(image7);

		image8 = new FlxSprite(841, 257).loadGraphic(Paths.image('freeplay/pictures/spike'));
		image8.visible = false;
		add(image8);

		image9 = new FlxSprite(841, 257).loadGraphic(Paths.image('freeplay/pictures/starved-butch'));
		image9.visible = false;
		add(image9);

		image10 = new FlxSprite(841, 257).loadGraphic(Paths.image('freeplay/pictures/wheel tom'));
		image10.visible = false;
		add(image10);

		song = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/come-for-revenge'));
		song.visible = true;
		add(song);

		song1 = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/reburning'));
		song1.visible = false;
		add(song1);

		song2 = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/none-of-all'));
		song2.visible = false;
		add(song2);

		song3 = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/invade'));
		song3.visible = false;
		add(song3);

		song4 = new FlxSprite(130, 350).loadGraphic(Paths.image('freeplay/songs/jammy'));
		song4.visible = false;
		add(song4);

		song5 = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/soul-chance'));
		song5.visible = false;
		add(song5);

		song6 = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/meme-mania'));
		song6.visible = false;
		add(song6);

		song7 = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/mucho-mouse'));
		song7.visible = false;
		add(song7);

		song8 = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/hydrophobia'));
		song8.visible = false;
		add(song8);

		song9 = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/desire-or-despair'));
		song9.visible = false;
		add(song9);

		song10 = new FlxSprite(150, 340).loadGraphic(Paths.image('freeplay/songs/steep-slopes'));
		song10.visible = false;
		add(song10);

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

		image6.frames = Paths.getSparrowAtlas('freeplay/pictures/meme_mouse/meme_mouse_${FlxG.random.int(1, 5)}');
		image6.animation.addByPrefix('idle', 'idle', 65);
		image6.animation.play('idle');

		switch(ProductSelected)
		{
			case 1:
				image.visible = false;
				image10.visible = false;
				image1.visible = true;
				song.visible = true;
				song10.visible = false;
				song1.visible = false;
				selectedString = "come-for-revenge";

			case 2:
				image.visible = false;
				image1.visible = true;
				image2.visible = false;
				image10.visible = false;
				song1.visible = true;
				song.visible = false;
				song2.visible = false;
				song10.visible = false;
				selectedString = "reburning";

			case 3:
				image1.visible = false;
				image2.visible = true;
				image3.visible = false;
				song2.visible = true;
				song1.visible = false;
				song3.visible = false;
				selectedString = "none-of-all";

			case 4:
				image2.visible = false;
				image3.visible = true;
				image4.visible = false;
				song2.visible = false;
				song3.visible = true;
				song4.visible = false;
				selectedString = "invade";

			case 5:
				image3.visible = false;
				image4.visible = true;
				image5.visible = false;
				song3.visible = false;
				song4.visible = true;
				song5.visible = false;
				selectedString = "jam";

			case 6:
				image4.visible = false;
				image5.visible = true;
				image6.visible = false;
				song4.visible = false;
				song5.visible = true;
				song6.visible = false;
				selectedString = "soul-chance";

			case 7:
				image5.visible = false;
				image6.visible = true;
				image7.visible = false;
				song5.visible = false;
				song6.visible = true;
				song7.visible = false;
				selectedString = "meme-mania";

			case 8:
				image6.visible = false;
				image7.visible = true;
				image8.visible = false;
				song6.visible = false;
				song7.visible = true;
				song8.visible = false;
				selectedString = "mucho-mouse";

			case 9:
				image7.visible = false;
				image8.visible = true;
				image9.visible = false;
				song7.visible = false;
				song8.visible = true;
				song9.visible = false;
				selectedString = "hydrophobia";

			case 10:
				image8.visible = false;
				image9.visible = true;
				image10.visible = false;
				image.visible = false;
				image1.visible = false;
				song8.visible = false;
				song9.visible = true;
				song10.visible = false;
				song.visible = false;
				song1.visible = false;
				image.visible = false;
				selectedString = "desire-or-despair";

			case 11:
				image9.visible = false;
				image10.visible = true;
				image.visible = false;
				image1.visible = false;
				song9.visible = false;
				song10.visible = true;
				song.visible = false;
				song1.visible = false;
				selectedString = "steep-slopes";
		}

		if(ProductSelected >= 11)
			ProductSelected = 11;
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