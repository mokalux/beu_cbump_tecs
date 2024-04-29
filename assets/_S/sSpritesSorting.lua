SSpritesSorting = Core.class()

function SSpritesSorting:init(xtiny) -- tiny function
	xtiny.processingSystem(self) -- called once on init and every update
	self.spriteslist = xtiny.spriteslist
end

function SSpritesSorting:filter(ent) -- tiny function
	return ent.sprite
end

function SSpritesSorting:onAdd(ent) -- tiny function
end

function SSpritesSorting:onRemove(ent) -- tiny function
	self.spriteslist[ent] = nil
	ent = nil
end

local p1rangetoofar = myappwidth*0.9 -- disable system to save some CPU, magik XXX
function SSpritesSorting:process(ent, dt) -- tiny function
--	local function fun()
		for k, _ in pairs(self.spriteslist) do
			if k.currlives <= 0 or ent.currlives <= 0 then return end  -- don't sort if dead
			if k.isplayer1 then -- don't sort out of screen actors to save some frames?
				if -(ent.x-k.x)<>(ent.x-k.x) > p1rangetoofar then return end
			end
			if ent.isactionjump1 or ent.isactionjumppunch1 or ent.isactionjumpkick1 then
				if ent.positionystart < k.positionystart and -- ent is behind
					ent.spritelayer:getChildIndex(ent.sprite) > k.spritelayer:getChildIndex(k.sprite) then -- sprite is in front
					ent.spritelayer:swapChildren(ent.sprite, k.sprite)
				end
			else
				if ent.y < k.y and -- ent is behind
					ent.spritelayer:getChildIndex(ent.sprite) > k.spritelayer:getChildIndex(k.sprite) then -- sprite is in front
					ent.spritelayer:swapChildren(ent.sprite, k.sprite)
				end
			end
		end
--	end
--	Core.asyncCall(fun) -- seems to be faster without asyncCall (because of pairs traversing?)
end






