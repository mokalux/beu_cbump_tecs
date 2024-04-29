Options = Core.class(Sprite)

local keyNames = {
  [KeyCode.LEFT] = "LEFT",
  [KeyCode.RIGHT] = "RIGHT",
  [KeyCode.UP] = "UP",
  [KeyCode.DOWN] = "DOWN",
  [KeyCode.NUM0] = "NUMPAD 0",
  [KeyCode.NUM1] = "NUMPAD 1",
  [KeyCode.NUM2] = "NUMPAD 2",
  [KeyCode.NUM3] = "NUMPAD 3",
  [KeyCode.NUM4] = "NUMPAD 4",
  [KeyCode.NUM5] = "NUMPAD 5",
  [KeyCode.NUM6] = "NUMPAD 6",
  [KeyCode.NUM7] = "NUMPAD 7",
  [KeyCode.NUM8] = "NUMPAD 8",
  [KeyCode.NUM9] = "NUMPAD 9",
  [KeyCode.SPACE] = "SPACE",
  [KeyCode.SHIFT] = "SHIFT",
  [KeyCode.CTRL] = "CONTROL",
  [KeyCode.ALT] = "ALT",
  [KeyCode.TAB] = "TAB",
}

function Options:init()
	-- bg
	application:setBackgroundColor(0x232a35)
	g_bgimg:setVisible(true)
	-- TITLE
	self.mytitle = ButtonMonster.new({
		autoscale=false, pixelwidth=16*8, pixelheight=4*8,
		pixelcolorup=0xaaaaaa,
		text="OPTIONS", ttf=myttf,
	})
	-- SLIDERS
	local slitcolor, knobcolor = 0x3a1d20, 0x8d595d
	self.bgmvolumeslider = ASlider.new({
		initialvalue=g_bgmvolume, maximum=100, --steps=2,
		slitcolor=slitcolor, slitalpha=1, slitw=5*myappwidth/10, slith=24,
		knobcolor=knobcolor, knobalpha=0.6, knobw=12, knobh=26,
		text="BGM VOLUME: ", textscale=2, textoffsetx=-26*8, textoffsety=7,
		id=1,
	})
	self.sfxvolumeslider = ASlider.new({
		initialvalue=g_sfxvolume, maximum=100, --steps=2,
		slitcolor=slitcolor, slitalpha=1, slitw=5*myappwidth/10, slith=24,
		knobcolor=knobcolor, knobalpha=0.6, knobw=12, knobh=26,
		text="SFX VOLUME: ", textscale=2, textoffsetx=-26*8, textoffsety=7,
		id=2,
	})
	self.difficultyslider = ASlider.new({
		initialvalue=g_difficulty, maximum=2, --steps=2,
		slitcolor=slitcolor, slitalpha=1, slitw=5*myappwidth/10, slith=24,
		knobcolor=knobcolor, knobalpha=0.6, knobw=12, knobh=26,
		text="DIFFICULTY: ", textscale=2, textoffsetx=-26*8, textoffsety=7, textrotation=0,
		id=3,
	})
	-- position
	self.mytitle:setPosition(myappwidth/2, 0.75*myappheight/10)
	self.bgmvolumeslider:setPosition(29*8, 2.5*myappheight/10)
	self.sfxvolumeslider:setPosition(29*8, 3.5*myappheight/10)
	self.difficultyslider:setPosition(29*8, 4.5*myappheight/10)
	-- order
	self:addChild(self.mytitle)
	self:addChild(self.bgmvolumeslider)
	self:addChild(self.sfxvolumeslider)
	self:addChild(self.difficultyslider)
	-- tooltip layer
	local tooltiplayer = Sprite.new()
	-- buttons
	local key
	self.sfxsound = {sound=Sound.new("audio/ui/sfx_sounds_button1.wav"), time=0, delay=0.2}
	self.sfxvolume = g_sfxvolume * 0.01
	-- movement
	if (keyNames[g_keyleft] or 0) == 0 then key = utf8.char(g_keyleft)
	else key = keyNames[g_keyleft]
	end
	self.btnLEFT = ButtonMonster.new({
		autoscale=false, pixelwidth=17*8, pixelheight=6*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text=key, ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=self.sfxsound, volume=self.sfxvolume,
		tooltiptext="left", tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx, tooltipoffsety=g_ui_theme.tooltipoffsety,
	}, 2, tooltiplayer)
	if (keyNames[g_keyright] or 0) == 0 then key = utf8.char(g_keyright)
	else key = keyNames[g_keyright]
	end
	self.btnRIGHT = ButtonMonster.new({
		autoscale=false, pixelwidth=17*8, pixelheight=6*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text=key, ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=self.sfxsound, volume=self.sfxvolume,
		tooltiptext="right", tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx, tooltipoffsety=g_ui_theme.tooltipoffsety,
	}, 3, tooltiplayer)
	if (keyNames[g_keyup] or 0) == 0 then key = utf8.char(g_keyup)
	else key = keyNames[g_keyup]
	end
	self.btnUP = ButtonMonster.new({
		autoscale=false, pixelwidth=17*8, pixelheight=6*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text=key, ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=self.sfxsound, volume=self.sfxvolume,
		tooltiptext="up", tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx, tooltipoffsety=g_ui_theme.tooltipoffsety,
	}, 1, tooltiplayer)
	if (keyNames[g_keydown] or 0) == 0 then key = utf8.char(g_keydown)
	else key = keyNames[g_keydown]
	end
	self.btnDOWN = ButtonMonster.new({
		autoscale=false, pixelwidth=17*8, pixelheight=6*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text=key, ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=self.sfxsound, volume=self.sfxvolume,
		tooltiptext="down", tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx, tooltipoffsety=g_ui_theme.tooltipoffsety,
	}, 4, tooltiplayer)
	-- actions
	if (keyNames[g_keyaction1] or 0) == 0 then key = utf8.char(g_keyaction1)
	else key = keyNames[g_keyaction1]
	end
	self.btnACTION1 = ButtonMonster.new({
		autoscale=false, pixelwidth=17*8, pixelheight=6*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text=key, ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=self.sfxsound, volume=self.sfxvolume,
		tooltiptext="punch1", tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx, tooltipoffsety=g_ui_theme.tooltipoffsety,
	}, 5, tooltiplayer)
	if (keyNames[g_keyaction2] or 0) == 0 then key = utf8.char(g_keyaction2)
	else key = keyNames[g_keyaction2]
	end
	self.btnACTION2 = ButtonMonster.new({
		autoscale=false, pixelwidth=17*8, pixelheight=6*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text=key, ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=self.sfxsound, volume=self.sfxvolume,
		tooltiptext="punch2", tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx, tooltipoffsety=g_ui_theme.tooltipoffsety,
	}, 6, tooltiplayer)
	if (keyNames[g_keyaction3] or 0) == 0 then key = utf8.char(g_keyaction3)
	else key = keyNames[g_keyaction3]
	end
	self.btnACTION3 = ButtonMonster.new({
		autoscale=false, pixelwidth=17*8, pixelheight=6*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text=key, ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=self.sfxsound, volume=self.sfxvolume,
		tooltiptext="jump punch", tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx, tooltipoffsety=g_ui_theme.tooltipoffsety,
	}, 7, tooltiplayer)
	if (keyNames[g_keyaction4] or 0) == 0 then key = utf8.char(g_keyaction4)
	else key = keyNames[g_keyaction4]
	end
	self.btnACTION4 = ButtonMonster.new({
		autoscale=false, pixelwidth=17*8, pixelheight=6*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text=key, ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=self.sfxsound, volume=self.sfxvolume,
		tooltiptext="kick1", tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx, tooltipoffsety=g_ui_theme.tooltipoffsety,
	}, 8, tooltiplayer)
	if (keyNames[g_keyaction5] or 0) == 0 then key = utf8.char(g_keyaction5)
	else key = keyNames[g_keyaction5]
	end
	self.btnACTION5 = ButtonMonster.new({
		autoscale=false, pixelwidth=17*8, pixelheight=6*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text=key, ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=self.sfxsound, volume=self.sfxvolume,
		tooltiptext="kick2", tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx, tooltipoffsety=g_ui_theme.tooltipoffsety,
	}, 9, tooltiplayer)
	if (keyNames[g_keyaction6] or 0) == 0 then key = utf8.char(g_keyaction6)
	else key = keyNames[g_keyaction6]
	end
	self.btnACTION6 = ButtonMonster.new({
		autoscale=false, pixelwidth=17*8, pixelheight=6*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text=key, ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=self.sfxsound, volume=self.sfxvolume,
		tooltiptext="jump kick", tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx, tooltipoffsety=g_ui_theme.tooltipoffsety,
	}, 10, tooltiplayer)
	-- btn menu
	self.btnMENU = ButtonMonster.new({
		autoscale=false, pixelwidth=12*8, pixelheight=6*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text="MENU", ttf=myttf, textcolorup=0x0009B3, textcolordown=0x45d1ff,
		sound=self.sfxsound, volume=self.sfxvolume,
		tooltiptext="Enter", tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx, tooltipoffsety=g_ui_theme.tooltipoffsety,
	}, 11, tooltiplayer)
	-- btns table
	self.btns = {}
	self.btns[#self.btns + 1] = self.btnUP -- 1
	self.btns[#self.btns + 1] = self.btnLEFT -- 2
	self.btns[#self.btns + 1] = self.btnRIGHT -- 3
	self.btns[#self.btns + 1] = self.btnDOWN -- 4
	self.btns[#self.btns + 1] = self.btnACTION1 -- 5
	self.btns[#self.btns + 1] = self.btnACTION2 -- 6
	self.btns[#self.btns + 1] = self.btnACTION3 -- 7
	self.btns[#self.btns + 1] = self.btnACTION4 -- 8
	self.btns[#self.btns + 1] = self.btnACTION5 -- 9
	self.btns[#self.btns + 1] = self.btnACTION6 -- 10
	self.btns[#self.btns + 1] = self.btnMENU -- 11
	self.selector = 1 -- starting button
	-- position
	self.btnLEFT:setPosition(1.5*myappwidth/10, 6*8+6*myappheight/10)
	self.btnRIGHT:setPosition(3.5*myappwidth/10, 6*8+6*myappheight/10)
	self.btnUP:setPosition(2.5*myappwidth/10, 6*8+4.6*myappheight/10)
	self.btnDOWN:setPosition(2.5*myappwidth/10, 6*8+7.4*myappheight/10)
	for i = 5, 7 do -- buttons (punch)
		self.btns[i]:setPosition(5.6*myappwidth/10, (i-5)*6*8+6*myappheight/10)
	end
	for i = 8, #self.btns-1 do -- buttons (kick)
		self.btns[i]:setPosition(7.6*myappwidth/10, (i-8)*6*8+6*myappheight/10)
	end
	self.btnMENU:setPosition(myappwidth - self.btnMENU:getWidth()/2, myappheight - self.btnMENU:getHeight()/2)
	-- order
	for k, v in ipairs(self.btns) do self:addChild(v) end
	self:addChild(tooltiplayer)
	-- sliders listeners
	self.bgmvolumeslider:addEventListener("value_just_changed", self.onValueJustChanged, self)
	self.bgmvolumeslider:addEventListener("value_changing", self.onValueChanging, self)
	self.bgmvolumeslider:addEventListener("value_changed", self.onValueChanged, self)
	self.sfxvolumeslider:addEventListener("value_just_changed", self.onValueJustChanged, self)
	self.sfxvolumeslider:addEventListener("value_changing", self.onValueChanging, self)
	self.sfxvolumeslider:addEventListener("value_changed", self.onValueChanged, self)
	self.difficultyslider:addEventListener("value_just_changed", self.onValueJustChanged, self)
	self.difficultyslider:addEventListener("value_changing", self.onValueChanging, self)
	self.difficultyslider:addEventListener("value_changed", self.onValueChanged, self)
	-- buttons listeners
	for k, v in ipairs(self.btns) do
--		v:addEventListener("pressed", function() self.selector = k self:goto() end)
		v:addEventListener("clicked", function() self.selector = k self:goto() end)
		v:addEventListener("hovered", function(e) self.selector = e.currselector end)
		v.btns = self.btns -- FOR KEYBOARD NAVIGATION!
	end
	-- let's go!
	self:difficulty(g_difficulty)
	self.isremapping = false
	-- scene transition listeners
	self:addEventListener("enterBegin", self.onTransitionInBegin, self)
	self:addEventListener("enterEnd", self.onTransitionInEnd, self)
	self:addEventListener("exitBegin", self.onTransitionOutBegin, self)
	self:addEventListener("exitEnd", self.onTransitionOutEnd, self)
end

-- sliders
function Options:difficulty(x) -- translate int to text
	if x >= 2 then self.difficultyslider.textfield:setText("DIFFICULTY: \e[color=#ddc]HARD\e[color]")
	elseif x >= 1 then self.difficultyslider.textfield:setText("DIFFICULTY: \e[color=#ddc]NORMAL\e[color]")
	else self.difficultyslider.textfield:setText("DIFFICULTY: \e[color=#ddc]EASY\e[color]")
	end
end
function Options:onValueJustChanged(e)
	if e.id == 1 then
		g_bgmvolume = e.value -- keep actual value, change in setVolume()
		self.bgmvolumeslider:setValue(g_bgmvolume)
	elseif e.id == 2 then
		g_sfxvolume = e.value -- keep actual value, change in setVolume()
		self.sfxvolumeslider:setValue(g_sfxvolume)
	elseif e.id == 3 then
		g_difficulty = e.value
		self:difficulty(g_difficulty)
	end
end
function Options:onValueChanging(e)
	if e.id == 1 then -- bgm volume
		g_bgmvolume = e.value -- keep actual value, change in setVolume()
		self.bgmvolumeslider:setValue(g_bgmvolume)
	elseif e.id == 2 then -- sfx volume
		g_sfxvolume = e.value -- keep actual value, change in setVolume()
		self.sfxvolumeslider:setValue(g_sfxvolume)
	elseif e.id == 3 then
		self:difficulty(e.value)
	end
end
function Options:onValueChanged(e)
	if e.id == 1 then
		g_bgmvolume = e.value -- keep actual value, change in setVolume()
		local audio = Sound.new("audio/sfx/sfx_wpn_laser4.wav")
		local channel = audio:play() -- feedback
		channel:setVolume(g_bgmvolume*0.01)
		self.bgmvolumeslider:setValue(g_bgmvolume)
	elseif e.id == 2 then
		g_sfxvolume = e.value -- keep actual value, change in setVolume()
		local audio = Sound.new("audio/sfx/sfx_wpn_laser4.wav")
		local channel = audio:play() -- feedback
		channel:setVolume(g_sfxvolume*0.01)
		self.sfxvolumeslider:setValue(g_sfxvolume)
		for _, v in pairs(self.btns) do v:setVolume(g_sfxvolume*0.01) end -- change the ui buttons sfx volume
	elseif e.id == 3 then
		g_difficulty = e.value
		self:difficulty(g_difficulty)
	end
	mySavePrefs(g_configfilepath)
end

function Options:remapKey(xbool)
	local btn = self.btns[self.selector]
	if xbool then
		self.isremapping = true
		btn:setColorTransform(255/255, 255/255, 0/255, 255/255)
	else
		btn:setColorTransform(255/255, 255/255, 255/255, 255/255)
	end
end

-- update button state
function Options:updateButton()
	for k, v in ipairs(self.btns) do
		v.currselector = self.selector
		v:updateVisualState()
		if k == self.selector then v:selectionSfx() end
	end
end

-- KEYS HANDLER
function Options:myKeysPressed()
	self:addEventListener(Event.KEY_DOWN, function(e)
		if self.isremapping then -- KEY REMAPPING
			if e.keyCode == KeyCode.ESC then
				self.isremapping = false
				self:remapKey(self.isremapping)
				self:updateButton()
				return
			end
			local keycode = e.keyCode
			local key = keyNames[keycode]
			if (keyNames[keycode] or 0) == 0 then key = utf8.char(keycode) end
			self.btns[self.selector]:changeText(key)
			if self.selector == 1 then g_keyup = keycode -- follows self.btns order
			elseif self.selector == 2 then g_keyleft = keycode -- follows self.btns order
			elseif self.selector == 3 then g_keyright = keycode -- follows self.btns order
			elseif self.selector == 4 then g_keydown = keycode -- follows self.btns order
			elseif self.selector == 5 then g_keyaction1 = keycode -- follows self.btns order
			elseif self.selector == 6 then g_keyaction2 = keycode -- follows self.btns order
			elseif self.selector == 7 then g_keyaction3 = keycode -- follows self.btns order
			elseif self.selector == 8 then g_keyaction4 = keycode -- follows self.btns order
			elseif self.selector == 9 then g_keyaction5 = keycode -- follows self.btns order
			elseif self.selector == 10 then g_keyaction6 = keycode -- follows self.btns order
			end
			self.isremapping = false
			self:remapKey(self.isremapping)
			self:updateButton()
			mySavePrefs(g_configfilepath)
		else -- NOT KEY REMAPPING
			if e.keyCode == KeyCode.ESC then self:back() end
			-- keyboard
			if e.keyCode == KeyCode.UP or e.keyCode == g_keyup or e.keyCode == KeyCode.LEFT or e.keyCode == g_keyleft then
				self.selector -= 1 if self.selector < 1 then self.selector = #self.btns end
				self:updateButton()
			elseif e.keyCode == KeyCode.DOWN or e.keyCode == g_keydown or e.keyCode == KeyCode.RIGHT or e.keyCode == g_keyright then
				self.selector += 1 if self.selector > #self.btns then self.selector = 1 end
				self:updateButton()
			end
			-- modifier
			local modifier = application:getKeyboardModifiers()
			local alt = (modifier & KeyCode.MODIFIER_ALT) > 0
			if not alt and (e.keyCode == KeyCode.ENTER or e.keyCode == KeyCode.SPACE or e.keyCode == g_keyaction1) then -- validate
				self:goto()
			elseif alt and e.keyCode == KeyCode.ENTER then -- switch full screen
				if not application:isPlayerMode() then
					ismyappfullscreen = not ismyappfullscreen
					application:setFullScreen(ismyappfullscreen)
				end
			end
		end
	end)
end

-- scene transitions
function Options:onTransitionInBegin() end
function Options:onTransitionInEnd()
	self:myKeysPressed()
	self:updateButton() -- update selected button state here otherwise bug
end
function Options:onTransitionOutBegin() self:removeAllListeners() end
function Options:onTransitionOutEnd() end

-- scenes navigation
function Options:goto()
	for k, v in ipairs(self.btns) do 
		if k == self.selector then
			if v.isdisabled then print("btn disabled!", k)
			elseif k >= 1 and k <= #self.btns-1 then self:remapKey(true) -- player1 controls/actions
			elseif k == #self.btns then self:back()
			else print("nothing here!", k)
			end
		end
	end
end
function Options:back()
	scenemanager:changeScene("menu", 1, transitions[1], easings[3])
end





