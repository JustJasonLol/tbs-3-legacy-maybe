package global;

import flixel.FlxCamera;
import flixel.FlxBasic;
import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import lime.app.Application;

#if desktop
import Discord.DiscordClient;
#end

//crash handler stuff
#if CRASH_HANDLER
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
#end

using StringTools;

typedef _G = {
	var width:Int;
	var height:Int;
	var initialState:Class<FlxState>;
	@:optional var zoom:Float;
	var framerate:Int;
	var skipSplash:Bool;
	var startFullscreen:Bool;
} 

class Main extends Sprite
{
	var game:_G = {
		width: 1280, // WINDOW width
		height: 720, // WINDOW height
		initialState: TitleState, // initial game state
		zoom: -1.0, // game state bounds
		framerate: 120, // default framerate
		skipSplash: false, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};

	public static var fpsVar:FPS;

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1.0)
		{
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			game.width = Math.ceil(stageWidth / game.zoom);
			game.height = Math.ceil(stageHeight / game.zoom);
		}
	
		ClientPrefs.loadDefaultKeys();
		addChild(new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.framerate, game.skipSplash, game.startFullscreen));

		#if !mobile
		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) {
			fpsVar.visible = ClientPrefs.showFPS;
		}
		#end

		if (Type.getClass(FlxG.state) == PlayState)
			FlxG.autoPause = true;
		else
			FlxG.autoPause = false;

		FlxG.mouse.visible = true;
		
		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

		#if desktop
		if (!DiscordClient.isInitialized) {
			DiscordClient.initialize();
			Application.current.window.onClose.add(function() {
				DiscordClient.shutdown();
			});
		}
		#end
	}

	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	// very cool person for real they don't get enough credit for their work
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "PsychEngine_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error + "\nPlease report this error to the GitHub page: https://github.com/ShadowMario/FNF-PsychEngine\n\n> Crash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		DiscordClient.shutdown();
		Sys.exit(1);
	}
	#end

	/**
	 * Checks to see if some FlxObject overlaps this FlxObject or FlxGroup. 
	 * 
	 * If the group has a LOT of things in it, it might be faster to use FlxG.overlaps(). 
	 * 
	 * **WARNING: Currently tilemaps do NOT support screen space overlap checks!**
	 * 
	 * ### Example of his use
	 * ```haxe
	 * 	// Checks if the cursor is overlapping at myCoolObject at the last camera on the list
	 * 	if (Main.mouseOverlaps(myCoolObject, FlxG.mouse.getPositionInCameraView(FlxG.cameras.list[FlxG.cameras.list.length - 1])))
	 * 	{
	 * 		myCoolObject.alpha = 0.5; // Sets the myCoolObject alpha to 0.5
	 * 
	 * 		if (FlxG.mouse.justPressed) // Checks if the mouse is pressed while overlapping myCoolObject
	 * 		{
	 * 			FlxG.switchState(new MyCoolState()); // Switches to another class/state
	 * 		}
	 * 	}
	 * 
	 * ```
	 * 
	 * @param ObjectOrGroup The object or group being tested.
	 * @param Camera Specify which game camera you want. If null getScreenPosition() will just grab the first global camera.
	 */
	public static function mouseOverlaps(spr:Dynamic, mousePos:flixel.math.FlxPoint):Bool
		{
			if (mousePos.x >= (spr.x - spr.offset.x)
				&& mousePos.x < (spr.x - spr.offset.x + spr.width)
				&& mousePos.y >= (spr.y - spr.offset.y)
				&& mousePos.y < (spr.y - spr.offset.y + spr.height))
			{
				return true;
			}
			
			//sad
			return false;
		}
}
