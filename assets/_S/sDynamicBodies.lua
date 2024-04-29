SDynamicBodies = Core.class()

local random = math.random

function SDynamicBodies:init(xtiny, xmapdef) -- tiny function
	xtiny.processingSystem(self) -- called once on init and every update
	self.mapdef = xmapdef
end

function SDynamicBodies:filter(ent) -- tiny function
	return ent.body -- only actors with body component
end

function SDynamicBodies:onAdd(ent) -- tiny function
end

function SDynamicBodies:onRemove(ent) -- tiny function
end

local randomdir = 0
function SDynamicBodies:process(ent, dt) -- tiny function
	-- is dead or hurt?
	if (ent.washurt and ent.washurt > 0) or (ent.wasbadlyhurt and ent.wasbadlyhurt > 0) or ent.currlives <= 0 then
		ent.body.vx = 0
		ent.body.vy = 0
		return
	end
	-- movement
	if ent.isleft and not ent.isright and ent.x > self.mapdef.l then -- LEFT
		ent.animation.curranim = g_ANIM_WALK_R
		ent.body.vx = -ent.body.currspeed
		ent.flip = -1
	elseif ent.isright and not ent.isleft and ent.x < self.mapdef.r - ent.w*0.5 then -- RIGHT
		ent.animation.curranim = g_ANIM_WALK_R
		ent.body.vx = ent.body.currspeed
		ent.flip = 1
	else -- IDLE
		ent.animation.curranim = g_ANIM_IDLE_R
		ent.body.vx = 0
	end
	if ent.isup and not ent.isdown and not (ent.isactionjump1 or ent.isactionjumppunch1 or ent.isactionjumpkick1) and ent.y > self.mapdef.t then -- UP
		ent.animation.curranim = g_ANIM_WALK_R
		ent.body.vy = -ent.body.currspeed*0.01 -- you choose, magik XXX
	elseif ent.isdown and not ent.isup and not (ent.isactionjump1 or ent.isactionjumppunch1 or ent.isactionjumpkick1) and ent.y < self.mapdef.b then -- DOWN
		ent.animation.curranim = g_ANIM_WALK_R
		ent.body.vy = ent.body.currspeed*0.01 -- you choose, magik XXX
	else
		if not ent.body.isgoingup and ent.y >= (ent.positionystart or -1000) then -- magik XXX
			ent.body.vy = 0
		end
	end
	-- actions
	if ent.isactionpunch1 and not (ent.isactionjump1 or ent.isactionjumppunch1 or ent.isactionjumpkick1) then
		ent.animation.curranim = g_ANIM_PUNCH_ATTACK1_R
		ent.body.vx *= 0.5 -- you choose, magik XXX
		ent.body.vy *= 0.5 -- you choose, magik XXX
	elseif ent.isactionpunch2 and not (ent.isactionjump1 or ent.isactionjumppunch1 or ent.isactionjumpkick1) then
		ent.animation.curranim = g_ANIM_PUNCH_ATTACK2_R
		ent.body.vx *= 0.5 -- you choose, magik XXX
		ent.body.vy *= 0.5 -- you choose, magik XXX
	elseif ent.isactionkick1 and not (ent.isactionjump1 or ent.isactionjumppunch1 or ent.isactionjumpkick1) then
		ent.animation.curranim = g_ANIM_KICK_ATTACK1_R
		ent.body.vx *= 0.5 -- you choose, magik XXX
		ent.body.vy *= 0.5 -- you choose, magik XXX
	elseif ent.isactionkick2 and not (ent.isactionjump1 or ent.isactionjumppunch1 or ent.isactionjumpkick1) then
		ent.animation.curranim = g_ANIM_KICK_ATTACK2_R
		ent.body.vx *= 0.5 -- you choose, magik XXX
		ent.body.vy *= 0.5 -- you choose, magik XXX
	elseif ent.isactionjump1 then
		ent.animation.curranim = g_ANIM_JUMP1_R
		ent.body.currjumpspeed = ent.body.jumpspeed
		if ent.body.isgoingup then ent.body.vy -= ent.body.currjumpspeed end
		if ent.y < ent.positionystart - ent.h*0.4 then -- apex,  you choose, magik XXX
			ent.body.vy += ent.body.currjumpspeed
			ent.body.isgoingup = false
		end
		if not ent.body.isgoingup and ent.y > ent.positionystart then
			ent.body.vy = 0
			ent.y = ent.positionystart
			ent.positionystart = -1000 -- magik XXX
			ent.isactionjump1 = false -- sometimes bug! XXX
		elseif not ent.body.isgoingup and ent.body.vy == 0 then -- catches the sometimes bug!
			ent.body.vy += ent.body.currjumpspeed*10 -- makes the actor touch the ground, magik XXX
		end
	elseif ent.isactionjumppunch1 then
		ent.animation.curranim = g_ANIM_PUNCHJUMP_ATTACK1_R
		ent.body.currjumpspeed = ent.body.jumpspeed
		if ent.body.isgoingup then ent.body.vy -= ent.body.currjumpspeed end
		if ent.y < ent.positionystart - ent.h*0.3 then -- apex,  you choose, magik XXX
			ent.body.vy += ent.body.currjumpspeed
			ent.body.isgoingup = false
		end
		if not ent.body.isgoingup and ent.y > ent.positionystart then
			ent.body.vy = 0
			ent.y = ent.positionystart
			ent.positionystart = -1000 -- magik XXX
			ent.isactionjumppunch1 = false -- sometimes bug! XXX
			if ent.isnme then
				randomdir = random(100)
				if randomdir < 50 then ent.isleft = false ent.isright = true -- magik XXX
				else ent.isleft = true ent.isright = false
				end
			end
		elseif not ent.body.isgoingup and ent.body.vy == 0 then -- catches the sometimes bug!
			ent.body.vy += ent.body.currjumpspeed*10 -- makes the actor touch the ground, magik XXX
		end
	elseif ent.isactionjumpkick1 then
		ent.animation.curranim = g_ANIM_KICKJUMP_ATTACK1_R
		ent.body.currjumpspeed = ent.body.jumpspeed
		if ent.body.isgoingup then ent.body.vy -= ent.body.currjumpspeed end
		if ent.y < ent.positionystart - ent.h*0.5 then -- apex,  you choose, magik XXX
			ent.body.vy += ent.body.currjumpspeed
			ent.body.isgoingup = false
		end
		if not ent.body.isgoingup and ent.y > ent.positionystart then
			ent.body.vy = 0
			ent.y = ent.positionystart
			ent.positionystart = -1000 -- magik XXX
			ent.isactionjumpkick1 = false -- sometimes bug!
			if ent.isnme then
				randomdir = random(100)
				if randomdir < 50 then ent.isleft = false ent.isright = true -- magik XXX
				else ent.isleft = true ent.isright = false
				end
			end
		elseif not ent.body.isgoingup and ent.body.vy == 0 then -- catches the sometimes bug!
			ent.body.vy += ent.body.currjumpspeed*10 -- makes the actor touch the ground, magik XXX
		end
	end
	-- flip here?
	ent.animation.bmp:setScale(ent.sx * ent.flip, ent.sy)
end


