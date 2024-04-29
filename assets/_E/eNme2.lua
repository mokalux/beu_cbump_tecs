ENme2 = Core.class()

function ENme2:init(xspritelayer, x, y, dx, dy, xsplatlayer)
	-- ids
	self.isnme = true
	-- sprite layer
	self.spritelayer = xspritelayer
	self.splatlayer = xsplatlayer
	-- params
	self.x = x
	self.y = y
	self.sx = 1.3 -- 1.5
	self.sy = self.sx
	self.totallives = 2
	self.totalhealth = 2
	self.recovertimer = 8
	self.recoverbadtimer = 60
	self.actiontimer = math.random(32, 96) -- 16,48 32,32 50,70 -- magik XXX
	if g_difficulty == 0 then -- easy
		self.totallives = 1
		self.totalhealth = 1
		self.recovertimer = 0.5*8
		self.recoverbadtimer = 0.5*60
		self.actiontimer = math.random(2*32, 2*96)
	elseif g_difficulty == 2 then -- hard
		self.totallives = 2
		self.totalhealth = 3
		self.recovertimer = 2*8
		self.recoverbadtimer = 2*60
		self.actiontimer = math.random(0.5*32, 0.5*96)
	end
	self.hitfx = Bitmap.new(Texture.new("gfx/fx/1.png"))
	self.hitfx:setAnchorPoint(0.5, 0.5)
	-- ANIMATION COMPONENT: CAnimation:init(xspritesheetpath, xcols, xrows, xanimspeed, xoffx, xoffy, sx, sy)
	local texpath = "gfx/nmes/Chad_m_0001.png"
	local framerate = 1/10 -- 1/12
	self.animation = CAnimation.new(texpath, 10, 6, framerate, 0, 0, self.sx, self.sy)
	self.sprite = self.animation.sprite
--	self.sprite:setColorTransform(math.random(0, 255)/255, math.random(0, 255)/255, math.random(0, 255)/255, 1)
	self.animation.sprite = nil -- free some memory?
	self.w, self.h = self.sprite:getWidth(), self.sprite:getHeight()
	-- create basics animations, CAnimation:createAnim(xanimname, xstart, xfinish)
	self.animation:createAnim(g_ANIM_DEFAULT, 1, 18) -- fluid is best
	self.animation:createAnim(g_ANIM_IDLE_R, 1, 18) -- fluid is best
	self.animation:createAnim(g_ANIM_WALK_R, 19, 27) -- fluid is best
	self.animation:createAnim(g_ANIM_HURT_R, 56, 58) -- fluid is best
	self.animation:createAnim(g_ANIM_STANDUP_R, 29, 31) -- fluid is best
	self.animation:createAnim(g_ANIM_LOSE1_R, 56, 58) -- fluid is best
	-- COLLISION BOX COMPONENT: CCollisionBox:init(xcollwidth, xcollheight)
	local collw, collh = self.w*0.4, 8*self.sy -- magik XXX
	self.collbox = CCollisionBox.new(collw, collh)
	-- hurt box
	local hhbw, hhbh = self.w/2, self.h/3 -- magik XXX
	self.headhurtbox = {
		isactive=false,
		x=-3*self.sx,
		y=0*self.sy-self.h/2-self.collbox.h/2,
		w=hhbw,
		h=hhbh,
	}
	local shbw, shbh = self.w/2, self.h/3 -- magik XXX
	self.spinehurtbox = {
		isactive=false,
		x=-3*self.sx,
		y=0*self.sy-shbh/2+self.collbox.h/2,
		w=shbw,
		h=shbh,
	}
	-- create hit animations: CAnimation:createAnim(xanimname, xstart, xfinish)
	self.animation:createAnim(g_ANIM_PUNCH_ATTACK1_R, 28, 34) -- no or low anticipation / quick hit / no or low overhead is best
	self.animation:createAnim(g_ANIM_KICK_ATTACK1_R, 41, 46) -- no or low anticipation / quick hit / no or low overhead is best
	self.animation:createAnim(g_ANIM_PUNCHJUMP_ATTACK1_R, 35, 40) -- no or low anticipation / quick hit / no or low overhead is best
	self.animation:createAnim(g_ANIM_KICKJUMP_ATTACK1_R, 47, 55) -- no or low anticipation / quick hit / no or low overhead is best
	-- clean up
	self.animation.myanimsimgs = nil -- free some memory?
	-- hit box
	self.headhitboxattack1 = {
		isactive=false,
		hitstartframe=1,
		hitendframe=6,
		damage=1,
		x=self.collbox.w*0.7,
		y=-self.h*0.5+collh*0.5,
		w=20*self.sx,
		h=self.h
	}
	self.spinehitboxattack1 = {
		isactive=false,
		hitstartframe=3,
		hitendframe=4,
		damage=1,
		x=self.collbox.w*0.75,
		y=-self.h*0.4,
		w=32*self.sx,
		h=48*self.sy,
	}
	self.headhitboxjattack1 = {
		isactive=false,
		hitstartframe=2,
		hitendframe=4,
		damage=2,
		x=self.collbox.w*0.7,
		y=-self.h*0.6,
		w=40*self.sx,
		h=40*self.sy,
	}
	self.spinehitboxjattack1 = {
		isactive=false,
		hitstartframe=6,
		hitendframe=8,
		damage=2,
		x=self.collbox.w*0.5,
		y=-self.h*0.25+collh*0.5,
		w=48*self.sx,
		h=self.h*0.5,
	}
	-- BODY COMPONENTS: CBody:init(xspeed, xjumpspeed)
	self.body = CBody.new(math.random(3*16, 5*16), math.random(40, 56)/100) -- xspeed, xjumpspeed
	-- AI COMPONENT: CAI:init(x, y, dx, dy)
	self.ai = CAI.new(self.x, self.y, dx, dy)
	-- SHADOW COMPONENT: CShadow:init(xshadowx, xshadowy, xparentw, xshadowsx, xshadowsy)
	self.shadow = CShadow.new(self.x, self.y, self.w/1.5)
	self.spritelayer:addChild(self.shadow.sprite)
end



