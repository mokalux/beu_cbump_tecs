Menu = Core.class(Sprite)

function Menu:init()
	-- bg
	application:setBackgroundColor(0x232a35)
	g_bgimg:setVisible(true)
	-- buttons
	local sndbtn = {sound=Sound.new("audio/ui/sfx_sounds_button1.wav"), time=0, delay=0.2}
	local sfxvolume = g_sfxvolume * 0.01
	local tooltiplayer = Sprite.new()
	local difficulty = g_difficulty
	if difficulty >= 2 then difficulty = "hard"
	elseif difficulty >= 1 then difficulty = "normal"
	else difficulty = "easy"
	end
	local mybtn = ButtonMonster.new({
		autoscale=false, pixelwidth=20*8, pixelheight=8*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text="START", ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=sndbtn, volume=sfxvolume,
		tooltiptext=difficulty, tooltipttf=myttf, tooltiptextcolor=g_ui_theme.tooltiptextcolor,
		tooltipoffsetx=g_ui_theme.tooltipoffsetx-1.7*8, tooltipoffsety=g_ui_theme.tooltipoffsety+0.5*8,
	}, 1, tooltiplayer)
	local mybtn02 = ButtonMonster.new({
		autoscale=false, pixelwidth=20*8, pixelheight=8*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text="OPTIONS", ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=sndbtn, volume=sfxvolume,
	}, 2)
	local mybtn03 = ButtonMonster.new({
		autoscale=false, pixelwidth=20*8, pixelheight=8*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=0xff0000, -- red
		text="EXIT", ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=sndbtn, volume=sfxvolume,
	}, 3)
	-- buttons table for keyboard navigation
	self.btns = {}
	self.btns[#self.btns + 1] = mybtn
	self.btns[#self.btns + 1] = mybtn02
	self.btns[#self.btns + 1] = mybtn03
	self.selector = 1 -- starting button
	-- position
	mybtn:setPosition(12*myappwidth/16, 4*myappheight/16)
	mybtn02:setPosition(12*myappwidth/16, 8*myappheight/16)
	mybtn03:setPosition(12*myappwidth/16, 13*myappheight/16)
	-- order
	for k, v in ipairs(self.btns) do self:addChild(v) end
	self:addChild(tooltiplayer)
	-- buttons listeners
	for k, v in ipairs(self.btns) do
		v:addEventListener("clicked", function() self.selector = k self:goto() end)
		v:addEventListener("hovered", function(e) self.selector = e.currselector end)
		v.btns = self.btns -- FOR KEYBOARD NAVIGATION
	end
	-- scene transition listeners
	self:addEventListener("enterBegin", self.onTransitionInBegin, self)
	self:addEventListener("enterEnd", self.onTransitionInEnd, self)
	self:addEventListener("exitBegin", self.onTransitionOutBegin, self)
	self:addEventListener("exitEnd", self.onTransitionOutEnd, self)
end

-- update button state
function Menu:updateButton()
	for k, v in ipairs(self.btns) do
		v.currselector = self.selector
		v:updateVisualState()
		if k == self.selector then v:selectionSfx() end
	end
end

-- scene transitions
function Menu:onTransitionInBegin() end
function Menu:onTransitionInEnd()
	self:myKeysPressed()
	self:updateButton() -- update selected button state here otherwise bug
end
function Menu:onTransitionOutBegin() self:removeAllListeners() end
function Menu:onTransitionOutEnd() end

-- keyboard navigation
function Menu:myKeysPressed()
	self:addEventListener(Event.KEY_DOWN, function(e)
		if e.keyCode == KeyCode.UP or e.keyCode == g_keyup or
			e.keyCode == KeyCode.LEFT or e.keyCode == g_keyleft then
			self.selector -= 1 if self.selector < 1 then self.selector = #self.btns end
			self:updateButton()
		elseif e.keyCode == KeyCode.DOWN or e.keyCode == g_keydown or
			e.keyCode == KeyCode.RIGHT or e.keyCode == g_keyright then
			self.selector += 1 if self.selector > #self.btns then self.selector = 1 end
			self:updateButton()
		elseif e.keyCode == KeyCode.SPACE or e.keyCode == g_keyaction1 then
			self:goto()
		elseif e.keyCode == KeyCode.ESC then
			if not application:isPlayerMode() then application:exit() else print("EXIT") end
		end
		-- modifier
		local modifier = application:getKeyboardModifiers()
		local alt = (modifier & KeyCode.MODIFIER_ALT) > 0
		if not alt and e.keyCode == KeyCode.ENTER then self:goto() -- validate
		elseif alt and e.keyCode == KeyCode.ENTER then -- switch full screen
			if not application:isPlayerMode() then
				ismyappfullscreen = not ismyappfullscreen
				application:setFullScreen(ismyappfullscreen)
			end
		end
	end)
end

-- scenes navigation
function Menu:goto()
	for k, v in ipairs(self.btns) do
		if k == self.selector then
			if v.isdisabled then print("btn disabled!", k)
			elseif k == 1 then scenemanager:changeScene("levelX", 1, transitions[1], easings[3])
			elseif k == 2 then scenemanager:changeScene("options", 1, transitions[2], easings[2])
			elseif k == 3 then
				if not application:isPlayerMode() then application:exit() else print("Exit button ", k) end
			end
		end
	end
end


