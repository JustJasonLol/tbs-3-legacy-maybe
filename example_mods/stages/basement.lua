function onCreate()
	-- background shit

	makeLuaSprite('basement', 'basement', -900, -450);
	setLuaSpriteScrollFactor('basement', 1.1, 1.1);
	scaleObject('basement', 1.1, 1.1);
                addLuaSprite('basement',false)

    makeAnimatedLuaSprite('CUpheqdshidA','CUpheqdshidA',-400,-200)
    scaleObject('CUpheqdshidA', 2.5, 2.5);
    addAnimationByPrefix('CUpheqdshidA','CUpheqdshid','CUpheqdshid',24,true)
  addLuaSprite('CUpheqdshidA',true)

end