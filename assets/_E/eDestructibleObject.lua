EDestructibleObject = Core.class()

function EDestructibleObject:init(xspritelayer, x, y, dx, dy)
	-- ids
	self.isdestructibleobject = true
	-- sprite layer
	self.spritelayer = xspritelayer
	-- params
	self.x = x
	self.y = y
	self.sx = 1
	self.sy = self.sx
	self.flip = math.random(100)
	if self.flip > 50 then self.flip = 1 else self.flip = -1 end
	self.totallives = 1
	self.totalhealth = 2
	self.currlives = self.totallives
	self.currhealth = self.totalhealth
	-- recovery
	self.washurt = 0
	self.wasbadlyhurt = 0
	self.recovertimer = 20
	self.hitfx = Bitmap.new(Texture.new("gfx/fx/1.png"))
	self.hitfx:setAnchorPoint(0.5, 0.5)
	-- sprite (non animated)
	local texpath = "gfx/breakable/Barrel_02_0012.png"
	self.sprite = Bitmap.new(Texture.new(texpath, false))
	self.sprite:setAnchorPoint(0.5, 0.5)
	self.sprite:setScale(self.sx*self.flip, self.sy)
	self.w, self.h = self.sprite:getWidth(), self.sprite:getHeight() -- with applied scale
	-- COLLISION BOX COMPONENT (xcollwidth, xcollheight)
	local collw, collh = self.w*1, 2*self.sy -- magik XXX
	self.collbox = CCollisionBox.new(collw, collh)
	self.sprite:setPosition(self.x+self.collbox.w/2, self.y-self.h/2+self.collbox.h/2)
	self.positionystart = self.y -- for sprite sorting
	-- hurt box
	local hhbw, hhbh = self.w, 1*self.h/4 -- magik XXX
	self.headhurtbox = {
		isactive=false,
		x=0*self.sx,
		y=-self.h+hhbh*0.5+self.collbox.h/2,
		w=hhbw,
		h=hhbh,
	}
	local shbw, shbh = self.w, 3*self.h/4 -- magik XXX
	self.spinehurtbox = {
		isactive=false,
		x=0*self.sx,
		y=self.collbox.h/2-shbh/2,
		w=shbw,
		h=shbh,
	}
	-- SHADOW COMPONENT: CShadow:init(xshadowx, xshadowy, xparentw, xshadowsx, xshadowsy)
	self.shadow = CShadow.new(self.x, self.y, self.w*1.5)
	self.spritelayer:addChild(self.shadow.sprite)
end




