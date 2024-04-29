SDestructibleObjects = Core.class()

local random, cos, sin = math.random, math.cos, math.sin
local insert = table.insert

function SDestructibleObjects:init(xtiny, xbworld) -- tiny function
	self.tiny = xtiny -- ref so we can remove entities from tiny system
	self.tiny.processingSystem(self) -- called once on init and every update
	self.bworld = xbworld
	-- sfx
	self.snd = Sound.new("audio/sfx/footstep/Forest02.wav")
	self.channel = self.snd:play(0, false, true)
end

function SDestructibleObjects:filter(ent) -- tiny function
	return ent.isdestructibleobject
end

function SDestructibleObjects:onAdd(ent) -- tiny function
end

function SDestructibleObjects:onRemove(ent) -- tiny function
--	print("SDestructibleObjects:onRemove(ent)")
	-- put a random collectible (or not!) (xspritelayer, x, y, dx, dy)
	local function fun()
		local el = ECollectible.new(ent.spritelayer, ent.x+ent.collbox.w/4, ent.y+ent.collbox.h/4, 0, 0)
		self.tiny.tworld:addEntity(el)
		self.bworld:add(el, el.x, el.y, el.collbox.w, el.collbox.h)
	end
	Core.asyncCall(fun)
	self.bworld:remove(ent) -- remove collision box from cbump world here!
end

function SDestructibleObjects:process(ent, dt) -- tiny function
	local function EffectExplode(s, scale, x, y, r, speed, texture)
		local p = Particles.new()
		p:setPosition(x, y)
		p:setTexture(texture)
		p:setScale(scale)
		s:addChild(p)
		local parts = {}
		for i = 1, 8 do
			local a = random() * 6.3
			local dx, dy = sin(a), cos(a)
			local sr = random() * r
			local px, py = dx * sr, dy * sr
			local ss = (speed or 1) * (1 + random())
			insert(parts,
				{
					x = px, y = py,
					speedX = dx * ss,
					speedY = dy * ss,
					speedAngular = random() * 4 - 2,
					decayAlpha = 0.95 + random() *0.04,
					ttl = 500,
					size = 10 + random() * 20
				}
			)
		end
		p:addParticles(parts)
		Core.yield(2)
		p:removeFromParent()
	end
	-- hurt fx
	if ent.washurt and ent.washurt > 0 then
		ent.washurt -= 1
		if ent.washurt < ent.recovertimer/2 then
			if ent.hitfx then ent.hitfx:setVisible(false) end
		end
		if ent.washurt <= 0 then
			ent.sprite:setColorTransform(1, 1, 1, 1)
		end
	end
	if ent.isdirty then -- hit
		self.channel = self.snd:play()
--		if self.channel then self.channel:setVolume(g_sfxvolume*0.01) end
		self.channel:setVolume(g_sfxvolume*0.01) -- sometimes bug!
		ent.hitfx:setVisible(true)
		ent.hitfx:setPosition(ent.x+ent.headhurtbox.x+4, ent.y+ent.headhurtbox.y) -- 4, magik XXX
		ent.spritelayer:addChild(ent.hitfx)
		ent.currhealth -= ent.damage
		ent.washurt = ent.recovertimer -- timer for a flash effect
		ent.sprite:setColorTransform(1, 1, 1, 3) -- a flash effect
		ent.isdirty = false
		if ent.currhealth <= 0 then
			--local function EffectExplode(s, scale, x, y, r, speed, texture)
			Core.asyncCall(EffectExplode, ent.spritelayer, 1.8,
				ent.x+ent.collbox.w/2, ent.y-ent.h/2, 12, 1.0, Texture.new("gfx/fx/fxBarrel_02_0011.png"))
			ent.spritelayer:removeChild(ent.hitfx)
			self.tiny.tworld:removeEntity(ent) -- sprite is removed in SDrawable
			self.tiny.numberofdestructibleobjects -= 1
		end
	end
end

