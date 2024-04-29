SAnimation = Core.class()

function SAnimation:init(xtiny)
	xtiny.processingSystem(self) -- called once on init and every frames
	self.sndstepgrass = Sound.new("audio/sfx/footstep/Grass02.wav")
	self.channel = self.sndstepgrass:play(0, false, true)
end

function SAnimation:filter(ent) -- tiny function
	return ent.animation
end

function SAnimation:onAdd(ent) -- tiny function
end

function SAnimation:onRemove(ent) -- tiny function
	ent.animation = nil -- free some memory? XXX
end

local checkanim
function SAnimation:process(ent, dt) -- tiny function
--	checkanim = ent.animation.curranim -- if you are sure all animations are set else use below ternary operator code
	-- luau ternary operator (no end at the end), it's a 1 liner and seems fast?
	checkanim = if ent.animation.anims[ent.animation.curranim] then ent.animation.curranim else g_ANIM_DEFAULT

	if not ent.doanimate then return end

	ent.animation.animtimer -= dt
	if ent.animation.animtimer < 0 then
		ent.animation.frame += 1
		ent.animation.animtimer = ent.animation.animspeed
		if checkanim == g_ANIM_DEFAULT then
			if ent.animation.frame > #ent.animation.anims[checkanim] then ent.animation.frame = 1 end
		elseif checkanim == g_ANIM_JUMPUP_R or checkanim == g_ANIM_JUMPDOWN_R or
			checkanim == g_ANIM_LOSE1_R or checkanim == g_ANIM_STANDUP_R then
			if ent.animation.frame > #ent.animation.anims[checkanim] then
				ent.animation.frame = #ent.animation.anims[checkanim]
			end
		elseif checkanim == g_ANIM_PUNCH_ATTACK1_R then
			ent.headhitbox = ent.headhitboxattack1
			if ent.animation.frame > #ent.animation.anims[checkanim] then
				ent.animation.frame = 1
				if not ent.isplayer1 then ent.isactionpunch1 = false end
				ent.headhitboxattack1.isactive = false
			elseif ent.animation.frame > ent.headhitbox.hitendframe then
				ent.headhitboxattack1.isactive = false
			elseif ent.animation.frame > ent.headhitbox.hitstartframe then
				ent.headhitboxattack1.isactive = true
			end
		elseif checkanim == g_ANIM_PUNCH_ATTACK2_R then
			ent.headhitbox = ent.headhitboxattack2
			if ent.animation.frame > #ent.animation.anims[checkanim] then
				ent.animation.frame = 1
				if not ent.isplayer1 then ent.isactionpunch2 = false end
				ent.headhitboxattack2.isactive = false
			elseif ent.animation.frame > ent.headhitbox.hitendframe then
				ent.headhitboxattack2.isactive = false
			elseif ent.animation.frame > ent.headhitbox.hitstartframe then
				ent.headhitboxattack2.isactive = true
			end
		elseif checkanim == g_ANIM_KICK_ATTACK1_R then
			ent.spinehitbox = ent.spinehitboxattack1
			if ent.animation.frame > #ent.animation.anims[checkanim] then
				ent.animation.frame = 1
				if not ent.isplayer1 then ent.isactionkick1 = false end
				ent.spinehitboxattack1.isactive = false
			elseif ent.animation.frame > ent.spinehitbox.hitendframe then
				ent.spinehitboxattack1.isactive = false
			elseif ent.animation.frame > ent.spinehitbox.hitstartframe then
				ent.spinehitboxattack1.isactive = true
			end
		elseif checkanim == g_ANIM_KICK_ATTACK2_R then
			ent.spinehitbox = ent.spinehitboxattack2
			if ent.animation.frame > #ent.animation.anims[checkanim] then
				ent.animation.frame = 1
				if not ent.isplayer1 then ent.isactionkick2 = false end
				ent.spinehitboxattack2.isactive = false
			elseif ent.animation.frame > ent.spinehitbox.hitendframe then
				ent.spinehitboxattack2.isactive = false
			elseif ent.animation.frame > ent.spinehitbox.hitstartframe then
				ent.spinehitboxattack2.isactive = true
			end
		elseif checkanim == g_ANIM_JUMP1_R then -- only jump not hitting
			if ent.animation.frame > #ent.animation.anims[checkanim] then
				ent.animation.frame = #ent.animation.anims[checkanim]
			end
		elseif checkanim == g_ANIM_PUNCHJUMP_ATTACK1_R then
			ent.headhitbox = ent.headhitboxjattack1
			if ent.animation.frame > #ent.animation.anims[checkanim] then
				ent.animation.frame = #ent.animation.anims[checkanim]
--				if not ent.isplayer1 then ent.isactionjumppunch1 = false end -- don't cancel a jump attack!
				ent.headhitboxjattack1.isactive = false -- TEST XXX
			else
				ent.headhitboxjattack1.isactive = true
			end
		elseif checkanim == g_ANIM_KICKJUMP_ATTACK1_R then
			ent.spinehitbox = ent.spinehitboxjattack1
			if ent.animation.frame > #ent.animation.anims[checkanim] then
				ent.animation.frame = #ent.animation.anims[checkanim]
--				if not ent.isplayer1 then ent.isactionjumpkick1 = false end -- don't cancel a jump attack!
				ent.spinehitboxjattack1.isactive = false
			else
				ent.spinehitboxjattack1.isactive = true
			end
		else
			-- player1 steps sound fx
			if ent.isplayer1 and
				(ent.animation.curranim == g_ANIM_WALK_R or ent.animation.curranim == g_ANIM_RUN_R) and
				(ent.animation.frame == 4 or ent.animation.frame == 9) then
				self.channel = self.sndstepgrass:play()
--				if self.channel then self.channel:setVolume(g_sfxvolume*0.01) end
				self.channel:setVolume(g_sfxvolume*0.01) -- sometimes bug!
			end
			-- loop animations
			if ent.animation.frame > #ent.animation.anims[checkanim] then
				ent.animation.frame = 1
			end
		end
		ent.animation.bmp:setTextureRegion(ent.animation.anims[checkanim][ent.animation.frame])
	end
end





