SShadow = Core.class()

function SShadow:init(xtiny) -- tiny function
	xtiny.processingSystem(self) -- called once on init and every update
end

function SShadow:filter(ent) -- tiny function
	return ent.shadow
end

function SShadow:onAdd(ent) -- tiny function
end

function SShadow:onRemove(ent) -- tiny function
	ent.spritelayer:removeChild(ent.shadow.sprite)
end

function SShadow:process(ent, dt) -- tiny function
	if ent.isactionjump1 or ent.isactionjumppunch1 or ent.isactionjumpkick1 then
		ent.shadow.sprite:setPosition(ent.x+ent.collbox.w/2, ent.positionystart+ent.collbox.h/2)
	else
		ent.shadow.sprite:setPosition(ent.x+ent.collbox.w/2, ent.y+ent.collbox.h/2)
	end
end











