-- this is a modified version of a script by MTFuture
-- https://www.youtube.com/watch?v=AgS4gzhIjBs
-- also i hate my life

--redthing x: 770
--marcospause x: 40
--resume x: 700
--restart x: 710
--exit x: 635
--quit x: 755
--pointer x: getProperty('h2.x') + 80
local tweentime = 0.3
local die = 0
local botplay = 0

function onPause() -- stops normal pause screen
	return Function_Stop;
end
function onCreate()
	die = 0
	tinocoPaused = false -- pause
	resume = false -- options
	restart = false
	exit = false
	precacheSound('tea-time') -- pre cache pause song
	makeLuaSprite('bg', nil, 0, 0) -- dark bg
	makeGraphic('bg', screenWidth, screenHeight, '000000')
	setProperty('bg.alpha', 0.4)
	setObjectCamera('bg', 'other')
	setProperty('bg.visible', false)
	addLuaSprite('bg')
        makeLuaSprite('left', 'pause/left', -1000, 100);
	scaleObject('left', 0.7, 0.7);
        setObjectCamera('left', 'other')
                addLuaSprite('left',true)
        makeLuaSprite('right2', 'pause/right2', 1200, -100);
	scaleObject('right2', 0.7, 0.7);
        setObjectCamera('right2', 'other')
                addLuaSprite('right2',true)
      makeLuaSprite('right', 'pause/right', -1000, 210);
	scaleObject('right', 0.7, 0.7);
        setObjectCamera('right', 'other')
                addLuaSprite('right',true)

	makeLuaSprite('box', 'pause/box', 470, 245) -- pause box
	setProperty('box.alpha', 1)
	setObjectCamera('box', 'other')
	scaleObject('box', 0.5, 0.5);
	setProperty('box.visible', false)
	makeLuaText('h2', 'RESUME', 600, 365, 315) -- options
	addLuaSprite('box')
	setObjectCamera('h2', 'other')
	setTextSize('h2', 30)
	setProperty('h2.visible', false)
	addLuaText('h2')
	setTextFont('h2', 'vcr.ttf')
	makeLuaText('h3', 'RESTART', 570, 379, 350)
	setObjectCamera('h3', 'other')
	setTextSize('h3', 30)
	setProperty('h3.visible', false)
	addLuaText('h3')
	setTextFont('h3', 'vcr.ttf')
	makeLuaText('h4', 'EXIT', 600, 330, 385)
	setObjectCamera('h4', 'other')
	setTextSize('h4', 30)
	setProperty('h4.visible', false)
	addLuaText('h4')
	setTextFont('h4', 'vcr.ttf')
	makeLuaSprite('pointydoingy', 'pause/arrow', 525, 1000) -- selector arrow
	setObjectCamera('pointydoingy', 'other')
	setProperty('pointydoingy.visible', false)
	addLuaSprite('pointydoingy')
	doTweenAlpha('pp', 'pointydoingy', 0, 0.01, 'linear')
	scaleObject('pointydoingy', 0.05, 0.05);
end

function onCreatePost()
	if getProperty('cpuControlled') == true then -- if ghost tapping is off
		botplay = 1
	end
end

function onUpdate()
	if tinocoPaused == true then -- if paused
		setProperty('bg.visible', true) -- pause screen bg
		setProperty('left.visible', true) -- left image
		setProperty('right.visible', true) -- right image
		setProperty('box.visible', true) -- box img
		setProperty('h2.visible', true) -- resume
		setProperty('h3.visible', true) -- restart
		setProperty('h4.visible', true) -- exit
		setProperty('pointydoingy.visible', true) -- selector
		doTweenAlpha('tween3', 'h2', 1, 0.1, 'linear') -- alpha animation
		doTweenAlpha('tween4', 'h3', 1, 0.1, 'linear')
		doTweenAlpha('tween5', 'h4', 1, 0.1, 'linear')
		doTweenAlpha('boz', 'box', 1, 0.1, 'linear')
		doTweenAlpha('tween7', 'pointydoingy', 1, 0.1, 'linear')
		doTweenX('left', 'left', 70, 0.2, 'linear') -- left img slide anim
		doTweenX('right', 'right', 766, 0.2, 'linear') -- right img slide anim
		doTweenX('right2', 'right2', 766, 0.2, 'linear') -- right img slide anim
		doTweenAlpha('lefta', 'left', 1, 0.001, 'linear') -- left alpha
		doTweenAlpha('right2a', 'right2', 1, 0.001, 'linear') -- left alpha
		doTweenAlpha('lefa', 'right', 1, 0.001, 'linear') -- right alpha
		setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition')-0) -- pause the song
		setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
		setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0) -- mute inst
		setProperty('vocals.volume', 0) -- mute vocals
	else -- not paused
		setProperty('bg.visible', false) -- bg gone
		doTweenX('left', 'left', -1000, tweentime, 'linear') -- bye bye left img
		doTweenX('right', 'right', 1200, tweentime, 'linear') -- adios right img
		doTweenX('right2', 'right2', 1200, tweentime, 'linear') -- adios right img
		doTweenAlpha('lefta', 'left', 0, 0.1, 'linear') -- alpha anim
		doTweenAlpha('right2a', 'right2', 1, 0.001, 'linear')
		doTweenAlpha('righta', 'right', 0, 0.1, 'linear')
		doTweenAlpha('tween3', 'h2', 0, 0.1, 'linear')
		doTweenAlpha('tween3', 'h2', 0, 0.1, 'linear')
		doTweenAlpha('tween4', 'h3', 0, 0.1, 'linear')
		doTweenAlpha('tween5', 'h4', 0, 0.1, 'linear')
		doTweenAlpha('boz', 'box', 0, 0.1, 'linear')
		doTweenAlpha('tween7', 'pointydoingy', 0, 0.1, 'linear')
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 1)
	end
	if resume == true then -- pointer y coords
		setProperty('pointydoingy.y', 320) -- resume
	elseif restart == true then
		setProperty('pointydoingy.y', 355) -- restart
	elseif exit == true then
		setProperty('pointydoingy.y', 390) -- exit
	end
	ILOVEBUTTONS()
end

function onGameOver()
	die = 1;
end

function ILOVEBUTTONS()
	if keyJustPressed('pause') and die == 0 then -- if pressed pause button
		if tinocoPaused == false then -- if not paused
			setProperty('cpuControlled', true) -- turn on botplay to stop the player from playing while paused
			playSound('tea-time', 0, 'pausesong') -- play pause song
			soundFadeIn('pausesong', 1, 0, 0.7) -- fade in song
			runTimer('loopmusic', 85.523, 0) -- loop music
			tinocoPaused = true -- it's paused now
			resume = true -- set selector to resume on pause
			restart = false
			exit = false
		elseif tinocoPaused == true and resume == true then -- if paused
			if botplay == 0 then -- if you have botplay off then
				setProperty('cpuControlled', false) -- botplay off
			end -- else (if botplay is on) then it stays on
			setProperty('vocals.volume', 1) -- unmute vocals
			stopSound('pausesong') -- stop pause music
			cancelTimer('loopmusic') -- cancel loop music timer thing
			tinocoPaused = false -- unpause
			resume = false
			restart = false
			exit = false
		elseif tinocoPaused == true and restart == true then -- restart
			restartSong(false);
		elseif tinocoPaused == true and exit == true then -- exit
			exitSong(false);
		end
	end
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') and tinocoPaused == true then -- selection
		if resume == true then
			resume = false
			restart = false
			exit = true
		elseif exit == true then
			resume = false
			restart = true
			exit = false
		elseif restart == true then
			resume = true
			restart = false
			exit = false
		end
	end
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') and tinocoPaused == true then
		if resume == true then
			resume = false
			restart = true
			exit = false
		elseif restart == true then
			resume = false
			restart = false
			exit = true
		elseif exit == true then
			resume = true
			restart = false
			exit = false
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'loopmusic' then
		playSound('tea-time', 0.7, 'pausesong') -- loop song
	end
end