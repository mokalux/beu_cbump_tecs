ECollectible = Core.class()

function ECollectible:init(xspritelayer, x, y, dx, dy)
	-- ids
	self.iscollectible = true
	-- sprite layer
	self.spritelayer = xspritelayer
	-- params
	self.x = x
	self.y = y
	self.sx = 1
	self.sy = self.sx
	self.flip = math.random(100)
	if self.flip > 80 then self.flip = 1
	else self.flip = -1
	end
	self.totallives = 1
	self.currlives = self.totallives
	self.totalhealth = 3
	self.currhealth = self.totalhealth
	self.washurt = 0
	self.recovertimer = 20
	self.actiontimer = math.random(32, 96) -- 16, 32, 32, math.random(50, 70) -- magik XXX
	self.curractiontimer = self.actiontimer
	self.hitfx = Bitmap.new(Texture.new("gfx/fx/1.png"))
	self.hitfx:setAnchorPoint(0.5, 0.5)
	-- ANIMATION COMPONENT
	local texpath = "gfx/collectible/Dragon Eggs 1.png"
	local framerate = 1/10 -- 20
	--function CAnimation:init(xspritesheetpath, xcols, xrows, xanimspeed, xoffx, xoffy, sx, sy)
	self.animation = CAnimation.new(texpath, 1, 1, framerate, 0, 0, self.sx, self.sy)
	self.sprite = self.animation.sprite
	self.sprite:setScale(self.sx*self.flip, self.sy)
--	self.sprite:setColorTransform(math.random(1, 5)/10, 0.9, 2, 2)
	self.animation.sprite = nil -- free some memory?
	self.w, self.h = self.sprite:getWidth(), self.sprite:getHeight()
--	self.positionystart = self.y + self.h/2
	self.positionystart = self.y
	-- create animations
	--function CAnimation:createAnim(xanimname, xstart, xfinish)
	self.animation:createAnim(g_ANIM_DEFAULT, 1, 1)
	self.animation:createAnim(g_ANIM_IDLE_R, 1, 1)
	self.animation.myanimsimgs = nil -- free some memory?
	-- BODY COMPONENTS: function CBody:init(xspeed, xjumpspeed)
	self.body = CBody.new(math.random(1*16, 3*16), math.random(40, 56)/100) -- xspeed, xjumpspeed
	self.body.defaultmass = 1
	self.body.currmass = self.body.defaultmass
	-- AI COMPONENT: function CAI:init(x, y, dx, dy)
--	self.ai = CAI.new(self.x, self.y, dx, dy)
	-- COLLISION BOX COMPONENT (xcolx, xcoly, xcolwidth, xcolheight)
--	self.collectiblebox = CCollisionBox.new(0, self.h/2, self.w/2, self.h/10)
--	self.collbox = CCollisionBox.new(0, self.h/2, self.w/2, self.h/10)
	local colh = self.h/10
--	self.collbox = CCollisionBox.new(0, self.h/2-colh/2, self.w/2, colh)
	self.collbox = CCollisionBox.new(self.w/2, colh)
	-- other boxes
	-- shape box
	self.shapebox = {
		x=0,
		y=0,
		w=self.w,
		h=self.h,
	}
--[[
	-- hurt box
	self.headhurtbox = {
		isactive=false,
		x=0,
		y=0,
		w=self.w,
		h=self.h,
	}
	self.spinehurtbox = {
		isactive=false,
		x=0,
		y=0,
		w=self.w,
		h=self.h,
	}
]]
	-- SHADOW COMPONENT: function CShadow:init(xshadowx, xshadowy, xparentw, xshadowsx, xshadowsy)
	self.shadow = CShadow.new(self.x, self.y, self.w/2)
	self.spritelayer:addChild(self.shadow.sprite)
end











