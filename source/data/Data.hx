package data;

import flixel.FlxG;
import flixel.util.FlxSave;

/**
 * Class used for Game progression and some other data
 */
class Data
{
   static var _saves:FlxSave;

   static var __data = FlxG.save.data;

   public static var week1Lock:String = 'locked';
   public static var week2Lock:String = 'locked';
   public static var week3Lock:String = 'locked';
   public static var week4Lock:String = 'locked';
   public static var week5Lock:String = 'locked';
   public static var week6Lock:String = 'locked';

   public static var _warned:Bool = false;
	
   public static function lock() 
   {
      if(FlxG.save.data.week1Lock == null) FlxG.save.data.week1Lock = "locked";
      if(FlxG.save.data.week2Lock == null) FlxG.save.data.week2Lock = "locked";
      if(FlxG.save.data.week3Lock == null) FlxG.save.data.week3Lock = "locked";
      if(FlxG.save.data.week4Lock == null) FlxG.save.data.week4Lock = "locked";
      if(FlxG.save.data.week5Lock == null) FlxG.save.data.week5Lock = "locked";
      if(FlxG.save.data.week6Lock == null) FlxG.save.data.week6Lock = "locked";
      
      FlxG.save.flush();
   }

   public static function save() 
   {
      FlxG.save.data.week1Lock = week1Lock;
      FlxG.save.data.week2Lock = week2Lock;
      FlxG.save.data.week3Lock = week3Lock;
      FlxG.save.data.week4Lock = week4Lock;
      FlxG.save.data.week5Lock = week5Lock;
      FlxG.save.data.week6Lock = week6Lock;

      FlxG.save.flush();

      _saves = new FlxSave();
      _saves.bind('Game', CoolUtil.getSavePath('BasementTeam'));
      _saves.flush();
      FlxG.log.add(_saves + '____' + FlxG.save.data);
   }

   public static function load() 
   {
      week1Lock = FlxG.save.data.week1Lock;
      week2Lock = FlxG.save.data.week2Lock;
      week3Lock = FlxG.save.data.week3Lock;
      week4Lock = FlxG.save.data.week4Lock;
      week5Lock = FlxG.save.data.week5Lock;
      week6Lock = FlxG.save.data.week6Lock;

      FlxG.save.flush();
   }
}