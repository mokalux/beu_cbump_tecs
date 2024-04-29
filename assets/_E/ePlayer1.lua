EPlayer1 = Core.class()

function EPlayer1:init(xspritelayer, x, y, xsplatlayer)
	-- ids
	self.isplayer1 = true
	self.doanimate = true -- to save some cpu
	-- sprite layer
	self.spritelayer = xspritelayer
	self.splatlayer = xsplatlayer
	-- params
	self.x = x
	self.y = y
	self.sx = 1
	self.sy = self.sx
	self.flip = 1
	self.totallives = 3
	self.totalhealth = 10
	self.currjumps = 5
	if g_difficulty == 0 then -- easy
		self.totallives = 5
		self.totalhealth = 20
		self.currjumps = 10
	elseif g_difficulty == 2 then -- hard
		self.currjumps = 3
	end
	self.currlives = self.totallives
	self.currhealth = self.totalhealth
	-- recovery
	self.washurt = 0
	self.wasbadlyhurt = 0
	self.recovertimer = 30
	self.recoverbadtimer = 120
	if g_difficulty == 0 then -- easy
		self.recovertimer = 2*30
		self.recoverbadtimer = 2*120
	elseif g_difficulty == 2 then -- hard
		self.recovertimer = 0.5*30
		self.recoverbadtimer = 0.5*120
	end
	self.ispaused = false -- 'P' key for pausing the game
	self.hitfx = Bitmap.new(Texture.new("gfx/fx/2.png"))
	self.hitfx:setAnchorPoint(0.5, 0.5)
	-- ANIMATION COMPONENT: CAnimation:init(xspritesheetpath, xcols, xrows, xanimspeed, xoffx, xoffy, sx, sy)
	local texpath = "gfx/player1/mh_blue_haired2m_0130.png"
	local framerate = 1/10 -- 1/12 -- magik XXX
	self.animation = CAnimation.new(texpath, 12, 11, framerate, 0, 0, self.sx, self.sy)
	self.sprite = self.animation.sprite
	self.animation.sprite = nil -- free some memory?
	self.w, self.h = self.sprite:getWidth(), self.sprite:getHeight() -- with applied scale
	print("player1 size: ", self.w, self.h)
	self.positionystart = -1000
	-- create basics animations: CAnimation:createAnim(xanimname, xstart, xfinish)
	self.animation:createAnim(g_ANIM_DEFAULT, 1, 15)
	self.animation:createAnim(g_ANIM_IDLE_R, 1, 15) -- fluid is best
	self.animation:createAnim(g_ANIM_WALK_R, 16, 26) -- fluid is best
	self.animation:createAnim(g_ANIM_JUMP1_R, 74, 76) -- fluid is best
	self.animation:createAnim(g_ANIM_HURT_R, 90, 100) -- fluid is best
	self.animation:createAnim(g_ANIM_STANDUP_R, 103, 113) -- fluid is best
	self.animation:createAnim(g_ANIM_LOSE1_R, 113, 124) -- fluid is best
	-- COLLISION BOX COMPONENT: CCollisionBox:init(xcollwidth, xcollheight)
	local collw, collh = self.w*0.5, 8*self.sy -- magik XXX
	self.collbox = CCollisionBox.new(collw, collh)
	-- hurt box
	local hhbw, hhbh = self.w/3, self.h/3 -- magik XXX
	self.headhurtbox = {
		isactive=false,
		x=-2*self.sx,
		y=0*self.sy-self.h/2-self.collbox.h*2,
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
	self.animation:createAnim(g_ANIM_PUNCH_ATTACK1_R, 28, 31) -- no or low anticipation / quick hit / no or low overhead is best
	self.animation:createAnim(g_ANIM_PUNCH_ATTACK2_R, 50, 54) -- low or mid anticipation / quick hit / low or mid overhead is best
	self.animation:createAnim(g_ANIM_KICK_ATTACK1_R, 35, 41) -- no or low anticipation / quick hit / no or low overhead is best
	self.animation:createAnim(g_ANIM_KICK_ATTACK2_R, 62, 68) -- low or mid anticipation / quick hit / low or mid overhead is best
	self.animation:createAnim(g_ANIM_PUNCHJUMP_ATTACK1_R, 75, 82) -- low or mid anticipation / quick hit / low or mid overhead is best
	self.animation:createAnim(g_ANIM_KICKJUMP_ATTACK1_R, 83, 88) -- low or mid anticipation / quick hit / low or mid overhead is best
	-- clean up
	self.animation.myanimsimgs = nil -- free some memory?
	-- hit box
	self.headhitboxattack1 = {
		isactive=false,
		hitstartframe=2,
		hitendframe=3,
		damage=1,
		x=self.collbox.w*0.6,
		y=-self.h*0.6+collh*0.5,
		w=20*self.sx,
		h=32*self.sy,
	}
	self.headhitboxattack2 = {
		isactive=false,
		hitstartframe=1,
		hitendframe=4,
		damage=2,
		x=self.collbox.w*0.75,
		y=-self.h*0.65+collh*0.5,
		w=32*self.sx,
		h=32*self.sy,
	}
	self.spinehitboxattack1 = {
		isactive=false,
		hitstartframe=2,
		hitendframe=4,
		damage=1,
		x=self.collbox.w*0.7,
		y=-self.h*0.25+collh*0.5,
		w=40*self.sx,
		h=self.h*0.5,
	}
	self.spinehitboxattack2 = {
		isactive=false,
		hitstartframe=2,
		hitendframe=4,
		damage=2,
		x=self.collbox.w*0.8,
		y=-self.h*0.25+collh*0.5,
		w=32*self.sx,
		h=self.h*0.5,
	}
	self.headhitboxjattack1 = {
		isactive=false,
		hitstartframe=6,
		hitendframe=8,
		damage=3,
		x=self.collbox.w*0.7,
		y=-self.h*0.5+collh*0.5,
		w=40*self.sx,
		h=self.h*0.5,
	}
	self.spinehitboxjattack1 = {
		isactive=false,
		hitstartframe=3,
		hitendframe=5,
		damage=3,
		x=self.collbox.w*0.5,
		y=-self.h*0.25+collh*0.5,
		w=64*self.sx,
		h=self.h*0.5,
	}
	-- BODY COMPONENTS: CBody:init(xspeed, xjumpspeed)
	self.body = CBody.new(7*16, 0.5) -- xspeed, xjumpspeed
	-- SHADOW COMPONENT: CShadow:init(xshadowx, xshadowy, xparentw, xshadowsx, xshadowsy)
	self.shadow = CShadow.new(self.x, self.y, self.w*0.75)
	self.spritelayer:addChild(self.shadow.sprite)
end




