ENme3 = Core.class()

function ENme3:init(xspritelayer, x, y, dx, dy, xsplatlayer)
	-- ids
	self.isnme = true
	-- sprite layer
	self.spritelayer = xspritelayer
	self.splatlayer = xsplatlayer
	-- params
	self.x = x
	self.y = y
	self.sx = 1.2 -- 1.5
	self.sy = self.sx
	self.totallives = 2
	self.totalhealth = 3
	self.recovertimer = 16
	self.recoverbadtimer = 60
	self.actiontimer = math.random(32, 64) -- 16, 32, 32, math.random(50, 70) -- magik XXX
	if g_difficulty == 0 then -- easy
		self.totallives = 1
		self.totalhealth = 1
		self.recovertimer = 0.5*16
		self.recoverbadtimer = 0.5*60
		self.actiontimer = math.random(2*32, 2*64)
	elseif g_difficulty == 2 then -- hard
		self.totallives = 2
		self.totalhealth = 4
		self.recovertimer = 2*16
		self.recoverbadtimer = 2*60
		self.actiontimer = math.random(0.5*32, 0.5*64)
	end
	self.hitfx = Bitmap.new(Texture.new("gfx/fx/1.png"))
	self.hitfx:setAnchorPoint(0.5, 0.5)
	-- ANIMATION COMPONENT: CAnimation:init(xspritesheetpath, xcols, xrows, xanimspeed, xoffx, xoffy, sx, sy)
	local texpath = "gfx/nmes/65bf1add77c22d1745a4790bM_0019.png"
	local framerate = 1/8 -- 1/10
	self.animation = CAnimation.new(texpath, 9, 6, framerate, 0, 0, self.sx, self.sy)
	self.sprite = self.animation.sprite
--	self.sprite:setColorTransform(math.random(0, 255)/255, math.random(0, 255)/255, math.random(0, 255)/255, 1)
	self.animation.sprite = nil -- free some memory?
	self.w, self.h = self.sprite:getWidth(), self.sprite:getHeight()
	-- create basics animations, CAnimation:createAnim(xanimname, xstart, xfinish)
	self.animation:createAnim(g_ANIM_DEFAULT, 1, 14) -- fluid is best
	self.animation:createAnim(g_ANIM_IDLE_R, 1, 14) -- fluid is best
	self.animation:createAnim(g_ANIM_WALK_R, 15, 20) -- fluid is best
	self.animation:createAnim(g_ANIM_HURT_R, 49, 53) -- fluid is best
	self.animation:createAnim(g_ANIM_STANDUP_R, 51, 53) -- fluid is best
	self.animation:createAnim(g_ANIM_LOSE1_R, 50, 51) -- fluid is best
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
		x=-0*self.sx,
		y=0*self.sy-shbh/2+self.collbox.h/2,
		w=shbw,
		h=shbh,
	}
	-- create hit animations: CAnimation:createAnim(xanimname, xstart, xfinish)
	self.animation:createAnim(g_ANIM_PUNCH_ATTACK1_R, 23, 28) -- no or low anticipation / quick hit / no or low overhead is best
	self.animation:createAnim(g_ANIM_KICK_ATTACK1_R, 38, 43) -- no or low anticipation / quick hit / no or low overhead is best
	self.animation:createAnim(g_ANIM_KICKJUMP_ATTACK1_R, 40, 42) -- no or low anticipation / quick hit / no or low overhead is best
	-- clean up
	self.animation.myanimsimgs = nil -- free some memory?
	-- hit box
	self.headhitboxattack1 = {
		isactive=false,
		hitstartframe=2,
		hitendframe=3,
		damage=1,
		x=self.collbox.w*0.6,
		y=-self.h*0.6,
		w=20*self.sx,
		h=20*self.sy,
	}
	self.spinehitboxattack1 = {
		isactive=false,
		hitstartframe=3,
		hitendframe=5,
		damage=1,
		x=self.collbox.w*0.75,
		y=-self.h*0.4,
		w=32*self.sx,
		h=48*self.sy,
	}
	self.spinehitboxjattack1 = {
		isactive=false,
		hitstartframe=1,
		hitendframe=3,
		damage=3,
		x=self.collbox.w*0.5,
		y=-self.h*0.25,
		w=60*self.sx,
		h=60*self.sy,
	}
	-- BODY COMPONENTS: CBody:init(xspeed, xjumpspeed)
	self.body = CBody.new(math.random(3*16, 5*16), math.random(40, 56)/100) -- xspeed, xjumpspeed
	-- AI COMPONENT: CAI:init(x, y, dx, dy)
	self.ai = CAI.new(self.x, self.y, dx, dy)
	-- SHADOW COMPONENT: CShadow:init(xshadowx, xshadowy, xparentw, xshadowsx, xshadowsy)
	self.shadow = CShadow.new(self.x, self.y, self.w/1.5)
	self.spritelayer:addChild(self.shadow.sprite)
end



