Win = Core.class(Sprite)

function Win:init()
	-- bg
	application:setBackgroundColor(0x232a35)
	g_bgimg:setVisible(true)
	-- we create a movie clip to spice up the win scene
	local frames = {}
	local imgnumstartat, imgnumendat = 1, 44 -- image name sequence (eg.: image004.jpg, image005.jpg, ...)
	for i = 1, imgnumendat-imgnumstartat+1 do
		local iter = imgnumstartat+i-1
		if iter < 10 then
			frames[#frames+1] = Bitmap.new(Texture.new("gfx/player1/win/party-m-0001m_000"..(imgnumstartat+i-1)..".png", true))
		elseif iter < 100 then
			frames[#frames+1] = Bitmap.new(Texture.new("gfx/player1/win/party-m-0001m_00"..(imgnumstartat+i-1)..".png", true))
		elseif iter < 1000 then
			frames[#frames+1] = Bitmap.new(Texture.new("gfx/player1/win/party-m-0001m_0"..(imgnumstartat+i-1)..".png", true))
		end
		frames[i]:setAnchorPoint(0.5, 0.5)
	end
	local anims = {}
	local timing = 8
	for i = 1, #frames do anims[i] = {(i-1)*timing+1, i*timing, frames[i]} end 
	-- add anim frames
	local mc_win = MovieClip.new(anims, true)
	mc_win:setGotoAction(imgnumendat*timing, imgnumstartat*timing)
	mc_win:gotoAndPlay(imgnumstartat*timing)
	-- typewriter effect
	local test = [[
	You defeated the bad boyz and made the city a better place.

	Game made using Gideros framework (what else?).

	Gfx and animations made using 3DPixel Anim.

	Programmer: mokalux 2024 ;-)
	]]
	local tw = TypeWriter.new(myttf, test, 5*100, 3) -- TypeWriter:init(font, text, speed, char)
	tw:setTextColor(0x55ff00)
	tw:setLayout( { w=myappwidth/1.8, flags=FontBase.TLF_CENTER } )
	tw:addEventListener("finished", function(e)
	end)
	-- buttons
	local sndbtn = {sound=Sound.new("audio/ui/sfx_sounds_button1.wav"), time=0, delay=0.2}
	local sfxvolume = g_sfxvolume * 0.01
	local tooltiplayer = Sprite.new()
	local mybtn = ButtonMonster.new({
		autoscale=false, pixelwidth=20*8, pixelheight=8*8,
		pixelscalexup=0.8, pixelscalexdown=0.9,
		pixelcolorup=g_ui_theme.pixelcolorup, pixelcolordown=g_ui_theme.pixelcolordown,
		text="MENU", ttf=myttf, textcolorup=g_ui_theme.textcolorup, textcolordown=g_ui_theme.textcolordown,
		sound=sndbtn, volume=sfxvolume,
	}, 1, tooltiplayer)
	-- buttons table for keyboard navigation
	self.btns = {}
	self.btns[#self.btns + 1] = mybtn
	self.selector = 1 -- starting button
	-- position
	mc_win:setPosition(3.5*myappwidth/16, 9*myappheight/16)
	tw:setPosition(5*myappwidth/16, 1*myappheight/16)
	mybtn:setPosition(8*myappwidth/16, 14*myappheight/16)
	-- order
	self:addChild(mc_win)
	self:addChild(tw)
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
function Win:updateButton()
	for k, v in ipairs(self.btns) do
		v.currselector = self.selector
		v:updateVisualState()
		if k == self.selector then v:selectionSfx() end
	end
end

-- scene transitions
function Win:onTransitionInBegin() end
function Win:onTransitionInEnd()
	self:myKeysPressed()
	self:updateButton() -- update selected button state here otherwise bug
end
function Win:onTransitionOutBegin() self:removeAllListeners() end
function Win:onTransitionOutEnd() end

-- keyboard navigation
function Win:myKeysPressed()
	self:addEventListener(Event.KEY_DOWN, function(e)
		if e.keyCode == KeyCode.UP or e.keyCode == g_keyup or
			e.keyCode == KeyCode.LEFT or e.keyCode == g_keyleft then
			self.selector -= 1 if self.selector < 1 then self.selector = #self.btns end
			self:updateButton()
		elseif e.keyCode == KeyCode.DOWN or e.keyCode == g_keydown or
			e.keyCode == KeyCode.RIGHT or e.keyCode == g_keyright then
			self.selector += 1 if self.selector > #self.btns then self.selector = 1 end
			self:updateButton()
		elseif e.keyCode == KeyCode.SPACE or e.keyCode == g_keyaction1 then self:goto()
		elseif e.keyCode == KeyCode.ESC then scenemanager:changeScene("menu", 1, transitions[1], easings[3])
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
function Win:goto()
	for k, v in ipairs(self.btns) do
		if k == self.selector then
			if v.isdisabled then print("btn disabled!", k)
			elseif k == 1 then scenemanager:changeScene("menu", 1, transitions[1], easings[3])
			end
		end
	end
end


