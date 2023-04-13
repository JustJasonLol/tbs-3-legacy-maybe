function onCreatePost()
    setProperty('camGame.alpha', 0)
    setProperty('camHUD.alpha', 0)
    setProperty('dad.alpha', 0.001)
    setProperty('camZooming', true)
    setProperty('iconP2.alpha', 0)
    setProperty('cameraSpeed', 1.7)
    setProperty('skipCountdown', true)

    makeLuaText('text', '', 0, 0, screenHeight * 0.68)
    screenCenter('text', 'x')
    setTextAlignment('text', 'center')
    setTextFont('text', 'fnf_vcr.ttf')
    setProperty('text.x', getProperty('text.x')-60)
    setTextSize('text', 39)
    setObjectCamera('text', 'camOther')
    addLuaText('text')
end

onSongStart = function()
    setProperty('songLength', 40 * 1000)
end

function onUpdate(elapsed)
    for i = 0, 3 do
        setPropertyFromGroup('opponentStrums', i, 'alpha', 0)
    end
end

function onBeatHit()
    if (curBeat > 112 and curBeat < 176) or (curBeat > 240 and curBeat < 368) then
        triggerEvent('Add Camera Zoom', '', '')
    end

    if curBeat == 16 then 
        doTweenAlpha('coolTween', 'camGame', 1, 5, 'sineInOut')
    end

    if curBeat == 24 then
        doTweenAlpha('coolTweenSequel', 'camHUD', 1, 4, 'cubeInOut')
    end

    if curBeat == 36 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 40 then
        setProperty('defaultCamZoom', 1.1)
    end

    if curBeat == 44 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 48 then
        doTweenZoom('theZoomTween', 'camGame', 0.9, 6, 'cubeInOut')
        doTweenAlpha('theOtherDumbTween', 'camGame', 0, 4, 'sineInOut')
        doTweenAlpha('coolTweenSequel', 'camHUD', 0, 4, 'cubeInOut')
    end

    if curBeat == 72 then
        setProperty('iconP2.alpha', 1)
        setProperty('dad.alpha', 1)
        setProperty('camGame.alpha', 1)
        setProperty('camHUD.alpha', 1)
        setProperty('songLength', getPropertyFromClass('flixel.FlxG', 'sound.music.length'))
        setProperty('health', 1)
        setScore(0)
        setMisses(0)
    end

    if curBeat == 104 then
        doTweenAlpha('coolTweenSequel', 'camHUD', 0, 1, 'cubeInOut')
    end

    if curBeat == 111 then
        setProperty('defaultCamZoom', 1.4)
    end

    if curBeat == 112 then
        setProperty('health', 1)
        setScore(0)
        setMisses(0)
        doTweenAlpha('coolTweenSequel', 'camHUD', 1, 0.8, 'cubeInOut')
        setProperty('defaultCamZoom', 0.9)
    end

    if curBeat == 176 then
        setProperty('defaultCamZoom', 1.1)
    end

    if curBeat == 240 then
        setProperty('defaultCamZoom', 0.9)
    end
end

function onStepHit()
    if curStep == 214 then
        text('*maniatic laugh', true, 100)
    end

    if curStep == 237 then
        text('Give Me Power', false, 30)
    end

    if curStep == 248 then
        text('')
    end
end

function onTweenCompleted(tag)
    if tag == "theZoomTween" then
        setProperty('defaultCamZoom', 0.9)
    end
end

function text(textString, isMinus, setX)
    setTextString('text', textString)
    setProperty('text.x', isMinus and getProperty('text.x')-setX or getProperty('text.x')+setX)
end