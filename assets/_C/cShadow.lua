CShadow = Core.class()

function CShadow:init(xshadowx, xshadowy, xparentw, xshadowsx, xshadowsy)
	self.sprite = Bitmap.new(Texture.new("gfx/fx/shadow.png"))
	local shadowsx = (self.sprite:getWidth()><xparentw)/(self.sprite:getWidth()<>xparentw)
	self.sprite:setScale(xshadowsx or shadowsx, xshadowsy or shadowsx)
	self.sprite:setAnchorPoint(0.5, 0.5)
	self.sprite:setAlpha(0.5)
	self.x = xshadowx
	self.y = xshadowy
	self.sprite:setPosition(self.x, self.y)
end
