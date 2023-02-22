-- Thank you so much XooleDev
-- Pls follow him

local CanSelect

SelectAmount = 1
SelectAmountBack = -1

local MaxProductLimit = 11
local MinProductLimit = 1

local ProductSelected
local ProductPrice

function onCreate()
	initSaveData('DataFolder', 'Folder')
	flushSaveData('DataFolder')
	MoneyAmount = getDataFromSave('DataFolder', 'Money') -- Do NOT Remove Money, unless you're changing all the variables   -- Listen to him 

	if songName == 'Freeplay1' then
		function onStartCountdown() 
			if not allowCountdown then
				return Function_Stop
			end
		
			if allowCountdown then
				return Function_Continue
			end
		end
		playMusic('freakyMenu', 0.8, true)

		makeLuaSprite('image', 'freeplay/pictures/come-for-revenge', 877, 293)
		addLuaSprite('image', true)
		setScrollFactor('image', 1, 1);
            setProperty('image.visible', false)

		makeLuaSprite('image1', 'freeplay/pictures/come-for-revenge', 877, 293)
		addLuaSprite('image1', true)
		setScrollFactor('image1', 1, 1);
            setProperty('image1.visible', false)

		makeLuaSprite('image2', 'freeplay/pictures/DOJ', 877, 293)
		addLuaSprite('image2', true)
		setScrollFactor('image2', 1, 1);
            setProperty('image2.visible', false)

          makeLuaSprite('image3', 'freeplay/pictures/invade', 877, 293)
		addLuaSprite('image3', true)
		setScrollFactor('image3', 1, 1);
            setProperty('image3.visible', false)

          makeLuaSprite('image4', 'freeplay/pictures/jam', 877, 293)
		addLuaSprite('image4', true)
		setScrollFactor('image4', 1, 1);
            setProperty('image4.visible', false)

          makeLuaSprite('image5', 'freeplay/pictures/lightning', 877, 293)
		addLuaSprite('image5', true)
		setScrollFactor('image5', 1, 1);
            setProperty('image5.visible', false)

          makeLuaSprite('image6', 'freeplay/pictures/meme-mania', 877, 293)
		addLuaSprite('image6', true)
		setScrollFactor('image6', 1, 1);
            setProperty('image6.visible', false)

          makeLuaSprite('image7', 'freeplay/pictures/mucho mouse', 877, 293)
		addLuaSprite('image7', true)
		setScrollFactor('image7', 1, 1);
            setProperty('image7.visible', false)

          makeLuaSprite('image8', 'freeplay/pictures/spike', 877, 293)
		addLuaSprite('image8', true)
		setScrollFactor('image8', 1, 1);
            setProperty('image8.visible', false)

          makeLuaSprite('image9', 'freeplay/pictures/starved-butch', 877, 293)
		addLuaSprite('image9', true)
		setScrollFactor('image9', 1, 1);
            setProperty('image9.visible', false)

          makeLuaSprite('image10', 'freeplay/pictures/wheel tom', 877, 293)
		addLuaSprite('image10', true)
		setScrollFactor('image10', 1, 1);
            setProperty('image10.visible', false)

		makeLuaSprite('song', 'freeplay/songs/come-for-revenge', 150, 340)
		addLuaSprite('song', true)
		setScrollFactor('song', 1, 1);
            setProperty('song.visible', false)

		makeLuaSprite('song1', 'freeplay/songs/reburning', 150, 340)
		addLuaSprite('song1', true)
		setScrollFactor('song1', 1, 1);
            setProperty('song1.visible', false)

          makeLuaSprite('song2', 'freeplay/songs/none-of-all', 150, 340)
		addLuaSprite('song2', true)
		setScrollFactor('song2', 1, 1);
            setProperty('song2.visible', false)

          makeLuaSprite('song3', 'freeplay/songs/invade', 150, 340)
		addLuaSprite('song3', true)
		setScrollFactor('song3', 1, 1);
            setProperty('song3.visible', false)

          makeLuaSprite('song4', 'freeplay/songs/jammy', 150, 340)
		addLuaSprite('song4', true)
		setScrollFactor('song4', 1, 1);
            setProperty('song4.visible', false)

          makeLuaSprite('song5', 'freeplay/songs/soul-chance', 150, 340)
		addLuaSprite('song5', true)
		setScrollFactor('song5', 1, 1);
            setProperty('song5.visible', false)

          makeLuaSprite('song6', 'freeplay/songs/meme-mania', 150, 340)
		addLuaSprite('song6', true)
		setScrollFactor('song6', 1, 1);
            setProperty('song6.visible', false)

          makeLuaSprite('song7', 'freeplay/songs/mucho-mouse', 150, 340)
		addLuaSprite('song7', true)
		setScrollFactor('song7', 1, 1);
            setProperty('song7.visible', false)

          makeLuaSprite('song8', 'freeplay/songs/hydrophobia', 150, 340)
		addLuaSprite('song8', true)
		setScrollFactor('song8', 1, 1);
            setProperty('song8.visible', false)

          makeLuaSprite('song9', 'freeplay/songs/desire-or-despair', 150, 340)
		addLuaSprite('song9', true)
		setScrollFactor('song9', 1, 1);
            setProperty('song9.visible', false)

		makeLuaSprite('song10', 'freeplay/songs/steep-slopes', 150, 340)
		addLuaSprite('song10', true)
		setScrollFactor('song10', 1, 1);
            setProperty('song10.visible', false)

		ProductSelected = 0

		return Function_Continue;
	end
end

function onUpdate()
	if songName == 'Freeplay1' then
              if keyJustPressed('pause') then
			exitMenu()
              end

		if keyboardJustPressed('SPACE') then
				playSound('play');
		end

		if keyboardJustPressed('UP') or keyboardJustPressed('DOWN') then

			if ProductSelected >= MaxProductLimit and keyboardJustPressed('DOWN') then
				ProductSelected = 1
			elseif ProductSelected <= MinProductLimit and keyboardJustPressed('UP') then
				ProductSelected = 11
			else
				if keyboardJustPressed('DOWN') then
					ProductSelected = ProductSelected + 1
				end
				if keyboardJustPressed('UP') then
					ProductSelected = ProductSelected - 1
				end
			end
			if ProductSelected == 1 then
                        setProperty('song.visible', true)
                        setProperty('song1.visible', false)
                        setProperty('song2.visible', false)
                        setProperty('song3.visible', false)
                        setProperty('song4.visible', false)
                        setProperty('song5.visible', false)
                        setProperty('song6.visible', false)
                        setProperty('song7.visible', false)
                        setProperty('song8.visible', false)
                        setProperty('song9.visible', false)
                        setProperty('song10.visible', false)
                        setProperty('image.visible', true)
                        setProperty('image1.visible', false)
                        setProperty('image2.visible', false)
                        setProperty('image3.visible', false)
                        setProperty('image4.visible', false)
                        setProperty('image5.visible', false)
                        setProperty('image6.visible', false)
                        setProperty('image7.visible', false)
                        setProperty('image8.visible', false)
                        setProperty('image9.visible', false)
                        setProperty('image10.visible', false)
                  elseif ProductSelected == 2 then
                        setProperty('song.visible', false)
                        setProperty('song1.visible', true)
                        setProperty('song2.visible', false)
                        setProperty('song3.visible', false)
                        setProperty('song4.visible', false)
                        setProperty('song5.visible', false)
                        setProperty('song6.visible', false)
                        setProperty('song7.visible', false)
                        setProperty('song8.visible', false)
                        setProperty('song9.visible', false)
                        setProperty('song10.visible', false)
                        setProperty('image.visible', false)
                        setProperty('image1.visible', true)
                        setProperty('image2.visible', false)
                        setProperty('image3.visible', false)
                        setProperty('image4.visible', false)
                        setProperty('image5.visible', false)
                        setProperty('image6.visible', false)
                        setProperty('image7.visible', false)
                        setProperty('image8.visible', false)
                        setProperty('image9.visible', false)
                        setProperty('image10.visible', false)
                 elseif ProductSelected == 3 then
                        setProperty('song.visible', false)
                        setProperty('song1.visible', false)
                        setProperty('song2.visible', true)
                        setProperty('song3.visible', false)
                        setProperty('song4.visible', false)
                        setProperty('song5.visible', false)
                        setProperty('song6.visible', false)
                        setProperty('song7.visible', false)
                        setProperty('song8.visible', false)
                        setProperty('song9.visible', false)
                        setProperty('song10.visible', false)
                        setProperty('image.visible', false)
                        setProperty('image1.visible', false)
                        setProperty('image2.visible', true)
                        setProperty('image3.visible', false)
                        setProperty('image4.visible', false)
                        setProperty('image5.visible', false)
                        setProperty('image6.visible', false)
                        setProperty('image7.visible', false)
                        setProperty('image8.visible', false)
                        setProperty('image9.visible', false)
                        setProperty('image10.visible', false)
                 elseif ProductSelected == 4 then
                        setProperty('song.visible', false)
                        setProperty('song1.visible', false)
                        setProperty('song2.visible', false)
                        setProperty('song3.visible', true)
                        setProperty('song4.visible', false)
                        setProperty('song5.visible', false)
                        setProperty('song6.visible', false)
                        setProperty('song7.visible', false)
                        setProperty('song8.visible', false)
                        setProperty('song9.visible', false)
                        setProperty('song10.visible', false)
                        setProperty('image.visible', false)
                        setProperty('image1.visible', false)
                        setProperty('image2.visible', false)
                        setProperty('image3.visible', true)
                        setProperty('image4.visible', false)
                        setProperty('image5.visible', false)
                        setProperty('image6.visible', false)
                        setProperty('image7.visible', false)
                        setProperty('image8.visible', false)
                        setProperty('image9.visible', false)
                        setProperty('image10.visible', false)
                 elseif ProductSelected == 5 then
                        setProperty('song.visible', false)
                        setProperty('song1.visible', false)
                        setProperty('song2.visible', false)
                        setProperty('song3.visible', false)
                        setProperty('song4.visible', true)
                        setProperty('song5.visible', false)
                        setProperty('song6.visible', false)
                        setProperty('song7.visible', false)
                        setProperty('song8.visible', false)
                        setProperty('song9.visible', false)
                        setProperty('song10.visible', false)
                        setProperty('image.visible', false)
                        setProperty('image1.visible', false)
                        setProperty('image2.visible', false)
                        setProperty('image3.visible', false)
                        setProperty('image4.visible', true)
                        setProperty('image5.visible', false)
                        setProperty('image6.visible', false)
                        setProperty('image7.visible', false)
                        setProperty('image8.visible', false)
                        setProperty('image9.visible', false)
                        setProperty('image10.visible', false)
                 elseif ProductSelected == 6 then
                        setProperty('song.visible', false)
                        setProperty('song1.visible', false)
                        setProperty('song2.visible', false)
                        setProperty('song3.visible', false)
                        setProperty('song4.visible', false)
                        setProperty('song5.visible', true)
                        setProperty('song6.visible', false)
                        setProperty('song7.visible', false)
                        setProperty('song8.visible', false)
                        setProperty('song9.visible', false)
                        setProperty('song10.visible', false)
                        setProperty('image.visible', false)
                        setProperty('image1.visible', false)
                        setProperty('image2.visible', false)
                        setProperty('image3.visible', false)
                        setProperty('image4.visible', false)
                        setProperty('image5.visible', true)
                        setProperty('image6.visible', false)
                        setProperty('image7.visible', false)
                        setProperty('image8.visible', false)
                        setProperty('image9.visible', false)
                        setProperty('image10.visible', false)
                 elseif ProductSelected == 7 then
                        setProperty('song.visible', false)
                        setProperty('song1.visible', false)
                        setProperty('song2.visible', false)
                        setProperty('song3.visible', false)
                        setProperty('song4.visible', false)
                        setProperty('song5.visible', false)
                        setProperty('song6.visible', true)
                        setProperty('song7.visible', false)
                        setProperty('song8.visible', false)
                        setProperty('song9.visible', false)
                        setProperty('song10.visible', false)
                        setProperty('image.visible', false)
                        setProperty('image1.visible', false)
                        setProperty('image2.visible', false)
                        setProperty('image3.visible', false)
                        setProperty('image4.visible', false)
                        setProperty('image5.visible', false)
                        setProperty('image6.visible', true)
                        setProperty('image7.visible', false)
                        setProperty('image8.visible', false)
                        setProperty('image9.visible', false)
                        setProperty('image10.visible', false)
                 elseif ProductSelected == 8 then
                        setProperty('song.visible', false)
                        setProperty('song1.visible', false)
                        setProperty('song2.visible', false)
                        setProperty('song3.visible', false)
                        setProperty('song4.visible', false)
                        setProperty('song5.visible', false)
                        setProperty('song6.visible', false)
                        setProperty('song7.visible', true)
                        setProperty('song8.visible', false)
                        setProperty('song9.visible', false)
                        setProperty('song10.visible', false)
                        setProperty('image.visible', false)
                        setProperty('image1.visible', false)
                        setProperty('image2.visible', false)
                        setProperty('image3.visible', false)
                        setProperty('image4.visible', false)
                        setProperty('image5.visible', false)
                        setProperty('image6.visible', false)
                        setProperty('image7.visible', true)
                        setProperty('image8.visible', false)
                        setProperty('image9.visible', false)
                        setProperty('image10.visible', false)
                 elseif ProductSelected == 9 then
                        setProperty('song.visible', false)
                        setProperty('song1.visible', false)
                        setProperty('song2.visible', false)
                        setProperty('song3.visible', false)
                        setProperty('song4.visible', false)
                        setProperty('song5.visible', false)
                        setProperty('song6.visible', false)
                        setProperty('song7.visible', false)
                        setProperty('song8.visible', true)
                        setProperty('song9.visible', false)
                        setProperty('song10.visible', false)
                        setProperty('image.visible', false)
                        setProperty('image1.visible', false)
                        setProperty('image2.visible', false)
                        setProperty('image3.visible', false)
                        setProperty('image4.visible', false)
                        setProperty('image5.visible', false)
                        setProperty('image6.visible', false)
                        setProperty('image7.visible', false)
                        setProperty('image8.visible', true)
                        setProperty('image9.visible', false)
                        setProperty('image10.visible', false)
                 elseif ProductSelected == 10 then
                        setProperty('song.visible', false)
                        setProperty('song1.visible', false)
                        setProperty('song2.visible', false)
                        setProperty('song3.visible', false)
                        setProperty('song4.visible', false)
                        setProperty('song5.visible', false)
                        setProperty('song6.visible', false)
                        setProperty('song7.visible', false)
                        setProperty('song8.visible', false)
                        setProperty('song9.visible', true)
                        setProperty('song10.visible', false)
                        setProperty('image.visible', false)
                        setProperty('image1.visible', false)
                        setProperty('image2.visible', false)
                        setProperty('image3.visible', false)
                        setProperty('image4.visible', false)
                        setProperty('image5.visible', false)
                        setProperty('image6.visible', false)
                        setProperty('image7.visible', false)
                        setProperty('image8.visible', false)
                        setProperty('image9.visible', true)
                        setProperty('image10.visible', false)
                 elseif ProductSelected == 11 then
                        setProperty('song.visible', false)
                        setProperty('song1.visible', false)
                        setProperty('song2.visible', false)
                        setProperty('song3.visible', false)
                        setProperty('song4.visible', false)
                        setProperty('song5.visible', false)
                        setProperty('song6.visible', false)
                        setProperty('song7.visible', false)
                        setProperty('song8.visible', false)
                        setProperty('song9.visible', false)
                        setProperty('song10.visible', true)
                        setProperty('image.visible', false)
                        setProperty('image1.visible', false)
                        setProperty('image2.visible', false)
                        setProperty('image3.visible', false)
                        setProperty('image4.visible', false)
                        setProperty('image5.visible', false)
                        setProperty('image6.visible', false)
                        setProperty('image7.visible', false)
                        setProperty('image8.visible', false)
                        setProperty('image9.visible', false)
                        setProperty('image10.visible', true)
			end
			removeLuaSprite('selectIcon')
			playSound('select');
		end
		if ProductSelected == 1 and keyboardJustPressed('SPACE') then
                    loadSong('come-for-revenge');
            elseif ProductSelected == 2 and keyboardJustPressed('SPACE') then
                    loadSong('reburning');
            elseif ProductSelected == 3 and keyboardJustPressed('SPACE') then
                    loadSong('none-of-all');
            elseif ProductSelected == 4 and keyboardJustPressed('SPACE') then
                    loadSong('Invade');
            elseif ProductSelected == 5 and keyboardJustPressed('SPACE') then
                    loadSong('jam');
            elseif ProductSelected == 6 and keyboardJustPressed('SPACE') then
                    loadSong('soul-chance');
            elseif ProductSelected == 7 and keyboardJustPressed('SPACE') then
                    loadSong('meme-mania');
            elseif ProductSelected == 8 and keyboardJustPressed('SPACE') then
                    loadSong('mucho-mouse');
            elseif ProductSelected == 9 and keyboardJustPressed('SPACE') then
                    loadSong('hydrophobia');
            elseif ProductSelected == 10 and keyboardJustPressed('SPACE') then
                    loadSong('desire-or-despair');
            elseif ProductSelected == 11 and keyboardJustPressed('SPACE') then
                    loadSong('steep-slopes');
		  end
          end
        end

function onTimerCompleted(tag, loops, loopsLeft)
	if keyJustPressed('pause') and songName == 'Freeplay1' then
		exitMenu();
	end
end

function exitMenu()
	setDataFromSave('DataFolder', 'Money', MoneyAmount)
	exitSong(true);
end