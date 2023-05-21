drain = false
drainMultipler = 0.5

chromZoomShader = 0.0001

function onCreate()
    luaDebugMode = true
    makeLuaSprite('_', nil, -400)
    makeGraphic('_', screenWidth * 5, screenHeight * 5, '000000')
    setProperty('_.alpha', 0)
    runHaxeCode("game.addBehindDad(game.getLuaObject('_'));")

    addHaxeLibrary('sys.io.File')
    addHaxeLibrary('flixel.tweens.FlxTween')

    runHaxeCode([[
        whoa = new FlxRuntimeShader(File.getContent('./mods/shaders/aberration.frag'), null, 140);
        whoa.setFloat('aberration', ]]..chromZoomShader..[[);
        whoa.setFloat('effectTime', ]]..chromZoomShader..[[);

        whoa2 = new FlxRuntimeShader(File.getContent('./mods/shaders/tiltShift.frag'), null, 140);
        whoa2.setFloat('bluramount', 0);

        FlxG.camera.setFilters([new ShaderFilter(whoa), new ShaderFilter(whoa2)]);

        chromZoomShader = ]]..chromZoomShader..[[
    ]])
    setProperty('camZooming', true)
end

function onUpdate(elapsed)
    runHaxeCode([[
        whoa.setFloat('aberration', ]]..chromZoomShader..[[);
        whoa.setFloat('effectTime', ]]..chromZoomShader..[[);
    ]])
end

function onBeatHit()
    if curBeat == 62 then
        setProperty('camZooming', false)
        setProperty('camGame.zoom', 1)
    end

    if curBeat == 63 then
        setProperty('camGame.zoom', 1.1)
    end

    if curBeat == 64 then
        drain = true
        drainMultipler = 0.7
    end

    if curBeat == 128 then
        drain = false
        doTweenAlpha('1', 'healthBar', 0, 1.3, 'expoOut')
        doTweenAlpha('2', 'healthBarBG', 0, 1.3, 'expoOut')
        doTweenAlpha('3', 'iconP1', 0, 1.3, 'expoOut')
        doTweenAlpha('4', 'iconP2', 0, 1.3, 'expoOut')
        doTweenAlpha('5', 'actualBar', 0, 1.3, 'expoOut')
        doTweenAlpha('6', 'scoreTxt', 0, 1.3, 'expoOut')
        doTweenAlpha('7', '_', 0.7, 1, 'expoOut')
        setProperty('defaultCamZoom', 1.17)
    end

    if curBeat == 190 then
        setProperty('defaultCamZoom', 1.21)
    end

    if curBeat == 192 then
        setProperty('defaultCamZoom', 1.26)
        runHaxeCode([[
            whoa2.setFloat('bluramount', 1.3);
         ]])
         doTweenAlpha('7', '_', 0.9, 1, 'expoOut')
         doTweenAlpha('a', 'dad', 0.1, 1, 'linear')
         setProperty('boyfriend.cameraPosition[0]', getProperty('boyfriend.cameraPosition[0]') - 185)

        for i = 0, 3 do
            noteTweenAlpha('tag_'..i, i, 0, 1, 'cubeInOut')
        end
    end

    if curBeat == 240 then
        runHaxeCode([[
            whoa2.setFloat('bluramount', 1.02);
         ]])
    end

    if curBeat == 240 then
        doTweenAlpha('a', 'dad', 1, 3, 'linear')
    end

    if curBeat == 256 then
        setProperty('defaultCamZoom', 0.9)
        runHaxeCode([[
            whoa2.setFloat('bluramount', 0);
         ]])
         doTweenAlpha('8', '_', 0, 1, 'expoOut')
         setProperty('boyfriend.cameraPosition[0]', getProperty('boyfriend.cameraPosition[0]') + 185)

        for i = 0, 3 do
            noteTweenAlpha('tag__'..i, i, 1, 1, 'cubeInOut')
        end

        drain = true
        drainMultipler = 1.1

        doTweenAlpha('1', 'healthBar', 1, 3, 'expoOut')
        doTweenAlpha('2', 'healthBarBG', 1, 3, 'expoOut')
        doTweenAlpha('3', 'iconP1', 1, 3, 'expoOut')
        doTweenAlpha('4', 'iconP2', 1, 1.3, 'expoOut')
        doTweenAlpha('5', 'actualBar', 1, 1.3, 'expoOut')
        doTweenAlpha('6', 'scoreTxt', 1, 1.3, 'expoOut')
    end
end

function opponentNoteHit()
    if drain and getProperty('health') > (0.024 * drainMultipler) then
        addHealth(-0.023*drainMultipler)
    end
end