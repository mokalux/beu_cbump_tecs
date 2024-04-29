LevelX = Core.class(Sprite)

local random = math.random
local ispaused = false

function LevelX:init()
	if not application:isPlayerMode() then
		local sw, sh = application:get("screenSize") -- the user's screen size!
		application:set("cursorPosition", sw, sh) -- 0, 0
	end
	-- tiny-ecs
	if not self.tiny then self.tiny = require "classes/tiny-ecs" end
	self.tiny.tworld = self.tiny.world()
	-- cbump (cworld)
	local bump = require "cbump"
	local bworld = bump.newWorld()
	-- game sprite
	local levelgfxlayer = Sprite.new() -- bg
	local splatlayer = Sprite.new() -- fx
	local actionlayer = Sprite.new() -- actors
	-- the level bg & fg
	local drawbglevel, drawfglevel
	local mapdef = {} -- actors walking area (rect: top, left, right, bottom)
	local camfollowoffsety
	if g_currlevel == 1 then
		drawbglevel = DrawLevelsTiled.new(
			{
				"gfx/levels/beu_lvl1/untitled_0001.png",
				"gfx/levels/beu_lvl1/untitled_0002.png",
				"gfx/levels/beu_lvl1/untitled_0003.png",
			}, 0*32)
		drawfglevel = DrawLevelsTiled.new(
			{
				"gfx/levels/beu_lvl1/beu_fg_lvl1_0001.png",
				"gfx/levels/beu_lvl1/beu_fg_lvl1_0002.png",
				"gfx/levels/beu_lvl1/beu_fg_lvl1_0003.png",
			}, 12*32)
		mapdef.t, mapdef.l = 9.3*32, 0*32 -- magik XXX
		mapdef.r, mapdef.b = drawbglevel.mapwidth, mapdef.t + 5.3*32 -- magik XXX
		camfollowoffsety = -2.5*32 -- -2.2*32 -- magik XXX
	elseif g_currlevel == 2 then
		drawbglevel = DrawLevelsTiled.new(
			{
				"gfx/levels/beu_lvl2/untitled_0001.png",
				"gfx/levels/beu_lvl2/untitled_0002.png",
				"gfx/levels/beu_lvl2/untitled_0003.png",
			}, 0*32)
		drawfglevel = DrawLevelsTiled.new(
			{
				"gfx/levels/beu_lvl1/beu_fg_lvl1_0001.png",
				"gfx/levels/beu_lvl1/beu_fg_lvl1_0002.png",
				"gfx/levels/beu_lvl1/beu_fg_lvl1_0003.png",
			}, 12*32)
		mapdef.t, mapdef.l = 8.55*32, 0*32 -- magik XXX
		mapdef.r, mapdef.b = drawbglevel.mapwidth, mapdef.t + 6*32 -- magik XXX
		camfollowoffsety = -2.5*32 -- magik XXX
	elseif g_currlevel == 3 then
		drawbglevel = DrawLevelsTiled.new(
			{
				"gfx/levels/beu_lvl3/untitled_0001.png",
				"gfx/levels/beu_lvl3/untitled_0002.png",
				"gfx/levels/beu_lvl3/untitled_0003.png",
			}, 0*32)
		drawfglevel = DrawLevelsTiled.new(
			{
				"gfx/levels/beu_lvl3/untitledfg_0001.png",
				"gfx/levels/beu_lvl3/untitledfg_0002.png",
				"gfx/levels/beu_lvl3/untitledfg_0003.png",
			}, 0*32)
		drawfglevel:setAlpha(0.9)
		mapdef.t, mapdef.l = 8.9*32, 0*32 -- magik XXX
		mapdef.r, mapdef.b = drawbglevel.mapwidth, mapdef.t + 6*32 -- magik XXX
		camfollowoffsety = -2.5*32 -- magik XXX
	end
	-- the actors
	self.tiny.spriteslist = {}
	-- some enemies (xspritelayer, x, y, dx, dy, xsplatlayer)
	self.tiny.numberofnmes = 0
	local el
	if g_currlevel == 1 then
		for i = 1, 8 do
			el = ENme1.new(actionlayer, random(myappwidth*0.5, mapdef.r-mapdef.l), random(mapdef.t, mapdef.b-1*32),
				random(12, 24)*16, random(myappheight*0.2), splatlayer)
			self.tiny.tworld:addEntity(el)
			self.tiny.numberofnmes += 1
			self.tiny.spriteslist[el] = true
			bworld:add(el, el.x, el.y, el.collbox.w, el.collbox.h)
		end
		for i = 1, 8 do
			el = ENme2.new(actionlayer, random(myappwidth*0.6, mapdef.r-mapdef.l), random(mapdef.t, mapdef.b-2*32),
				random(12, 24)*16, random(myappheight*0.1), splatlayer)
			self.tiny.tworld:addEntity(el)
			self.tiny.numberofnmes += 1
			self.tiny.spriteslist[el] = true
			bworld:add(el, el.x, el.y, el.collbox.w, el.collbox.h)
		end
		-- some destructible objects (xspritelayer, x, y, dx, dy)
		self.tiny.numberofdestructibleobjects = 8
	elseif g_currlevel == 2 then
		for i = 1, 8 do
			el = ENme1.new(actionlayer, random(myappwidth*0.5, mapdef.r-mapdef.l), random(mapdef.t, mapdef.b-1*32),
				random(12, 24)*16, random(myappheight*0.2), splatlayer)
			self.tiny.tworld:addEntity(el)
			self.tiny.numberofnmes += 1
			self.tiny.spriteslist[el] = true
			bworld:add(el, el.x, el.y, el.collbox.w, el.collbox.h)
		end
		for i = 1, 8 do
			el = ENme3.new(actionlayer, random(myappwidth*0.6, (mapdef.r-mapdef.l)), random(mapdef.t, mapdef.b-1*32),
				random(12, 24)*16, random(myappheight*0.1), splatlayer)
			self.tiny.tworld:addEntity(el)
			self.tiny.numberofnmes += 1
			self.tiny.spriteslist[el] = true
			bworld:add(el, el.x, el.y, el.collbox.w, el.collbox.h)
		end
		-- some destructible objects (xspritelayer, x, y, dx, dy)
		self.tiny.numberofdestructibleobjects = 8
	elseif g_currlevel == 3 then
		for i = 1, 8 do
			el = ENme1.new(actionlayer, random(myappwidth*0.5, mapdef.r-mapdef.l), random(mapdef.t, mapdef.b-1*32),
				random(12, 24)*16, random(myappheight*0.2), splatlayer)
			self.tiny.tworld:addEntity(el)
			self.tiny.numberofnmes += 1
			self.tiny.spriteslist[el] = true
			bworld:add(el, el.x, el.y, el.collbox.w, el.collbox.h)
		end
		for i = 1, 8 do
			el = ENme3.new(actionlayer, random(myappwidth*0.6, (mapdef.r-mapdef.l)), random(mapdef.t, mapdef.b-1*32),
				random(12, 24)*16, random(myappheight*0.1), splatlayer)
			self.tiny.tworld:addEntity(el)
			self.tiny.numberofnmes += 1
			self.tiny.spriteslist[el] = true
			bworld:add(el, el.x, el.y, el.collbox.w, el.collbox.h)
		end
		for i = 1, 2 do
			el = ENme4.new(actionlayer, random(myappwidth*0.7, (mapdef.r-mapdef.l)), random(mapdef.t, mapdef.b-2*32),
				random(12, 24)*16, random(myappheight*0.1), splatlayer)
			self.tiny.tworld:addEntity(el)
			self.tiny.numberofnmes += 1
			self.tiny.spriteslist[el] = true
			bworld:add(el, el.x, el.y, el.collbox.w, el.collbox.h)
		end
		-- a wagon
		self.extragfx = Bitmap.new(Texture.new("gfx/levels/beu_lvl3/subway_car.001_0013.png"))
		self.extragfx:setScale(0.65)
		self.wagonr = mapdef.r
		-- some destructible objects (xspritelayer, x, y, dx, dy)
		self.tiny.numberofdestructibleobjects = 8
	end
	-- destructible objects (xspritelayer, x, y, dx, dy)
	for i = 1, self.tiny.numberofdestructibleobjects do -- we create a couple of loots
		el = EDestructibleObject.new(actionlayer, random(myappwidth*0.5, (mapdef.r-mapdef.l)), random(mapdef.t, mapdef.b - 2*32),
			0, 0)
		self.tiny.tworld:addEntity(el)
		self.tiny.spriteslist[el] = true
		bworld:add(el, el.x, el.y, el.collbox.w, el.collbox.h)
	end
	-- the player (xspritelayer, x, y, xsplatlayer)
	self.player1 = EPlayer1.new(actionlayer, mapdef.l+1*32, mapdef.t+2*32, splatlayer)
	self.tiny.tworld:addEntity(self.player1)
	self.tiny.spriteslist[self.player1] = true
	bworld:add(self.player1, self.player1.x, self.player1.y, self.player1.collbox.w, self.player1.collbox.h)
	-- HUD
	local function map(v, minSrc, maxSrc, minDst, maxDst, clampValue)
		local newV = (v - minSrc) / (maxSrc - minSrc) * (maxDst - minDst) + minDst
		return not clampValue and newV or clamp(newV, minDst >< maxDst, minDst <> maxDst)
	end
	self.tiny.hud = Sprite.new()
	-- hud lives
	self.tiny.hudlives = {}
	local pixellife
	for i = 1, self.player1.currlives do
		pixellife = Pixel.new(0xffff00, 0.8, 16, 16)
		pixellife:setPosition(8+(i-1)*(16+8), 8)
		self.tiny.hud:addChild(pixellife)
		self.tiny.hudlives[i] = pixellife
	end
	-- hud health
	local hudhealthwidth = map(self.player1.currhealth, 0, self.player1.totalhealth, 0, 100)
	self.tiny.hudhealth = Pixel.new(0x00ff00, 2, hudhealthwidth, 8)
	self.tiny.hudhealth:setPosition(8, 8*3.5)
	self.tiny.hud:addChild(self.tiny.hudhealth)
	-- hud jumps
	self.tiny.hudcurrjumps = TextField.new(myttf2, "JUMPS: "..self.player1.currjumps)
	self.tiny.hudcurrjumps:setTextColor(0xffffff)
	self.tiny.hudcurrjumps:setPosition(8, 8*6.5)
	self.tiny.hud:addChild(self.tiny.hudcurrjumps)
	-- camera: yourScene is a Sprite in which you put all your graphics
	self.camera = GCam.new(levelgfxlayer) -- [, anchorX, anchorY]) -- anchor by default is (0.5, 0.5)
	self.camera:setAutoSize(true)
	self.camera:setBounds(myappwidth/2, mapdef.t+camfollowoffsety, mapdef.r-myappwidth/2, mapdef.b) -- left, top, right, bottom
	self.camera:setFollow(self.player1.sprite)
	self.camera:setFollowOffset(0, camfollowoffsety)
--	self.camera:setDebug(true)
	-- position
	if self.extragfx then self.extragfx:setPosition(random(mapdef.r*0.5, mapdef.r), 1*myappheight/10) end
	-- order
	levelgfxlayer:addChild(drawbglevel)
	if self.extragfx then levelgfxlayer:addChild(self.extragfx) end
	levelgfxlayer:addChild(splatlayer)
	levelgfxlayer:addChild(actionlayer)
	if drawfglevel then levelgfxlayer:addChild(drawfglevel) end
	self:addChild(self.camera)
	self:addChild(self.tiny.hud)
	-- add systems to tiny-ecs
	self.tiny.tworld:add(
		-- debug
--		SDebugCollision.new(self.tiny),
--	 	SDebugHurtBoxPlayer.new(self.tiny),
--	 	SDebugHurtBoxNme.new(self.tiny),
--		SDebugHitBoxPlayer.new(self.tiny, { true, true, true, true, false, false } ), -- the 6 abilities (granular debugging)
--		SDebugHitBoxNme.new(self.tiny, { true, true, true, true, true, true } ), -- the 6 abilities (granular debugging)
--		SDebugCollectible.new(self.tiny),
--		SDebugSpriteSorting.new(self.tiny),
		-- systems
		SDrawable.new(self.tiny),
		SAnimation.new(self.tiny),
		SPlayer1Control.new(self.tiny),
		SPlayer1.new(self.tiny),
		SNmes.new(self.tiny, bworld),
		SAI.new(self.tiny, self.player1),
		SDynamicBodies.new(self.tiny, mapdef),
		SDestructibleObjects.new(self.tiny, bworld),
		SCollectible.new(self.tiny, bworld, self.player1),
		SCollision.new(self.tiny, bworld),
		SHitboxHurtboxCollision.new(self.tiny),
		SShadow.new(self.tiny),
		SSpritesSorting.new(self.tiny)
	)
	-- listeners
	self:addEventListener("enterBegin", self.onTransitionInBegin, self)
	self:addEventListener("enterEnd", self.onTransitionInEnd, self)
	self:addEventListener("exitBegin", self.onTransitionOutBegin, self)
	self:addEventListener("exitEnd", self.onTransitionOutEnd, self)
end

-- game loop
local dt
local endleveltimer = 32 -- 128, 200, magik XXX
local x
function LevelX:onEnterFrame(e)
	if self.tiny.numberofnmes <= 0 then endleveltimer -= 1 end
	dt = e.deltaTime
	if not ispaused then
		if endleveltimer < 0 then
			g_currlevel += 1
			if g_currlevel > g_totallevel then
				endleveltimer = 32 -- reset end level timer
				g_currlevel = 1 -- reset current level
				scenemanager:changeScene("win", 3, transitions[random(#transitions)], easings[random(#easings)])
			else
				endleveltimer = 32 -- reset end level timer
				scenemanager:changeScene("levelX", 2, transitions[1], easings[3])
			end
		end
		if self.player1.isactionjump1 or self.player1.isactionjumppunch1 or self.player1.isactionjumpkick1 then
			self.camera:updateXOnly(dt)
		else
			self.camera:update(dt)
		end
		self.tiny.tworld:update(dt) -- tiny world (last)
		if self.extragfx then
			x = self.extragfx:getX()
			x -= 196*dt
			if x < -self.extragfx:getWidth() then x = self.wagonr end
			self.extragfx:setX(x)
		end
	end
end

-- event listeners
function LevelX:onTransitionInBegin() self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self) end
function LevelX:onTransitionInEnd()
	application:setBackgroundColor(0x232a35)
	g_bgimg:setVisible(false)
	self:myKeysPressed()
end
function LevelX:onTransitionOutBegin() self:removeAllListeners() end
function LevelX:onTransitionOutEnd() end

-- app keys handler
function LevelX:myKeysPressed()
	self:addEventListener(Event.KEY_DOWN, function(e)
		if e.keyCode == KeyCode.ESC then scenemanager:changeScene("menu", 1, transitions[2], easings[2]) end
		if e.keyCode == KeyCode.P then ispaused = not ispaused end
		-- modifier
		local modifier = application:getKeyboardModifiers()
		local alt = (modifier & KeyCode.MODIFIER_ALT) > 0
		-- validate
		if (not alt and e.keyCode == KeyCode.ENTER) then -- nothing here!
		elseif alt and e.keyCode == KeyCode.ENTER then -- switch full screen
			ismyappfullscreen = not ismyappfullscreen
			application:setFullScreen(ismyappfullscreen)
		end
	end)
end
