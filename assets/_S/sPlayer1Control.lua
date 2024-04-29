SPlayer1Control = Core.class()

function SPlayer1Control:init(xtiny) -- tiny function
--	xtiny.system(self) -- called only once on init (no update)
	self.tiny = xtiny
	self.tiny.system(self) -- called only once on init (no update)
end

function SPlayer1Control:filter(ent) -- tiny function
	return ent.isplayer1
end

function SPlayer1Control:onAdd(ent) -- tiny function
	stage:addEventListener(Event.KEY_DOWN, function(e) -- is stage the best?
		if ent.currlives > 0 then
			if e.keyCode == KeyCode.LEFT or e.keyCode == g_keyleft then ent.isleft = true end
			if e.keyCode == KeyCode.RIGHT or e.keyCode == g_keyright then ent.isright = true end
			if e.keyCode == KeyCode.UP or e.keyCode == g_keyup then ent.isup = true end
			if e.keyCode == KeyCode.DOWN or e.keyCode == g_keydown then ent.isdown = true end
			-- actions
			if e.keyCode == g_keyaction1 then
				ent.animation.frame = 0
				ent.isactionpunch1 = true
			end
			if e.keyCode == g_keyaction2 then
				ent.animation.frame = 0
				ent.isactionpunch2 = true
			end
			if e.keyCode == g_keyaction3 then
				if not (ent.isactionjump1 or ent.isactionjumppunch1 or ent.isactionjumpkick1) then
					ent.currjumps -= 1
					ent.animation.frame = 0
					ent.positionystart = ent.y
					ent.body.isgoingup = true
					if ent.currjumps >= 0 then ent.isactionjumppunch1 = true
					else ent.isactionjump1 = true
					end
					if ent.currjumps < 0 then ent.currjumps = 0 end
					self.tiny.hudcurrjumps:setText("JUMPS: "..ent.currjumps)
				end
			end
			if e.keyCode == g_keyaction4 then
				ent.animation.frame = 0
				ent.isactionkick1 = true
			end
			if e.keyCode == g_keyaction5 then
				ent.animation.frame = 0
				ent.isactionkick2 = true
			end
			if e.keyCode == g_keyaction6 then
				if not (ent.isactionjump1 or ent.isactionjumppunch1 or ent.isactionjumpkick1) then
					ent.currjumps -= 1
					ent.animation.frame = 0
					ent.positionystart = ent.y
					ent.body.isgoingup = true
					if ent.currjumps >= 0 then ent.isactionjumpkick1 = true
					else ent.isactionjump1 = true
					end
					if ent.currjumps < 0 then ent.currjumps = 0 end
					self.tiny.hudcurrjumps:setText("JUMPS: "..ent.currjumps)
				end
			end
		end
	end)
	stage:addEventListener(Event.KEY_UP, function(e) -- is the stage best?
		if ent.currlives > 0 then
			if e.keyCode == KeyCode.LEFT or e.keyCode == g_keyleft then ent.isleft = false end
			if e.keyCode == KeyCode.RIGHT or e.keyCode == g_keyright then ent.isright = false end
			if e.keyCode == KeyCode.UP or e.keyCode == g_keyup then ent.isup = false end
			if e.keyCode == KeyCode.DOWN or e.keyCode == g_keydown then ent.isdown = false end
			if e.keyCode == g_keyaction1 then ent.isactionpunch1 = false end
			if e.keyCode == g_keyaction2 then ent.isactionpunch2 = false end
			if e.keyCode == g_keyaction3 then end
			if e.keyCode == g_keyaction4 then ent.isactionkick1 = false end
			if e.keyCode == g_keyaction5 then ent.isactionkick2 = false end
			if e.keyCode == g_keyaction6 then end
		end
	end)
end
