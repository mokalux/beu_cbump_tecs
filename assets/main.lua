-- global prefs functions
function myLoadPrefs(xconfigfilepath)
	local mydata = getData(xconfigfilepath) -- try to read information from file
	if not mydata then -- if no prefs file, create it
		mydata = {}
		-- set prefs
		mydata.g_language = g_language
--		mydata.g_currlevel = g_currlevel
		mydata.g_difficulty = g_difficulty
		mydata.g_bgmvolume = g_bgmvolume
		mydata.g_sfxvolume = g_sfxvolume
		-- controls
		mydata.g_keyleft = g_keyleft
		mydata.g_keyright = g_keyright
		mydata.g_keyup = g_keyup
		mydata.g_keydown = g_keydown
		mydata.g_keyaction1 = g_keyaction1
		mydata.g_keyaction2 = g_keyaction2
		mydata.g_keyaction3 = g_keyaction3
		mydata.g_keyaction4 = g_keyaction4
		mydata.g_keyaction5 = g_keyaction5
		mydata.g_keyaction6 = g_keyaction6
		-- save prefs
		saveData(xconfigfilepath, mydata) -- create file and save datas
	else -- prefs file exists, use it!
		-- set prefs
		g_language = mydata.g_language
--		g_currlevel = mydata.g_currlevel
		g_difficulty = mydata.g_difficulty
		g_bgmvolume = mydata.g_bgmvolume
		g_sfxvolume = mydata.g_sfxvolume
		-- controls
		g_keyleft = mydata.g_keyleft
		g_keyright = mydata.g_keyright
		g_keyup = mydata.g_keyup
		g_keydown = mydata.g_keydown
		g_keyaction1 = mydata.g_keyaction1
		g_keyaction2 = mydata.g_keyaction2
		g_keyaction3 = mydata.g_keyaction3
		g_keyaction4 = mydata.g_keyaction4
		g_keyaction5 = mydata.g_keyaction5
		g_keyaction6 = mydata.g_keyaction6
	end
end
function mySavePrefs(xconfigfilepath)
	local mydata = {} -- clear the table
	-- set prefs
	mydata.g_language = g_language
--	mydata.g_currlevel = g_currlevel
	mydata.g_difficulty = g_difficulty
	mydata.g_bgmvolume = g_bgmvolume
	mydata.g_sfxvolume = g_sfxvolume
	-- controls
	mydata.g_keyleft = g_keyleft
	mydata.g_keyright = g_keyright
	mydata.g_keyup = g_keyup
	mydata.g_keydown = g_keydown
	mydata.g_keyaction1 = g_keyaction1
	mydata.g_keyaction2 = g_keyaction2
	mydata.g_keyaction3 = g_keyaction3
	mydata.g_keyaction4 = g_keyaction4
	mydata.g_keyaction5 = g_keyaction5
	mydata.g_keyaction6 = g_keyaction6
	-- save prefs
	saveData(xconfigfilepath, mydata) -- save new data
end

-- initial default global prefs values
g_configfilepath = "|D|configfile.txt"
g_language = application:getLanguage()
g_totallevel = 3
g_currlevel = 1
g_difficulty = 1 -- 0=easy, 1=normal, 2=hard
g_bgmvolume = 50 -- 0-100
g_sfxvolume = 50 -- 0-100
g_keyleft = KeyCode.LEFT
g_keyright = KeyCode.RIGHT
g_keyup = KeyCode.UP
g_keydown = KeyCode.DOWN
g_keyaction1 = KeyCode.D -- punch1
g_keyaction2 = KeyCode.S -- punch1
g_keyaction3 = KeyCode.Q -- jump/jump punch1
g_keyaction4 = KeyCode.C -- kick1
g_keyaction5 = KeyCode.X -- kick2
g_keyaction6 = KeyCode.W -- jump/jump kick1

-- load saved prefs from file (|D|configfile.txt)
myLoadPrefs(g_configfilepath)

-- anims, faster accessed via int than string
local i = 1
g_ANIM_DEFAULT = i
i += 1
g_ANIM_IDLE_R = i
i += 1
g_ANIM_WALK_R = i
i += 1
g_ANIM_RUN_R = i
i += 1
g_ANIM_JUMP1_R = i
i += 1
g_ANIM_WIN_R = i
i += 1
g_ANIM_HURT_R = i
i += 1
g_ANIM_STANDUP_R = i
i += 1
g_ANIM_LOSE1_R = i
i += 1
g_ANIM_PUNCH_ATTACK1_R = i
i += 1
g_ANIM_PUNCH_ATTACK2_R = i
i += 1
g_ANIM_KICK_ATTACK1_R = i
i += 1
g_ANIM_KICK_ATTACK2_R = i
i += 1
g_ANIM_PUNCHJUMP_ATTACK1_R = i
i += 1
g_ANIM_KICKJUMP_ATTACK1_R = i

-- scene manager
scenemanager = SceneManager.new(
	{
		["menu"] = Menu,
		["options"] = Options,
		["levelX"] = LevelX,
		["win"] = Win,
	}
)
stage:addChild(scenemanager)
scenemanager:changeScene("menu")

-- transitions & easings
transitions = {
	SceneManager.moveFromRight, -- 1
	SceneManager.moveFromLeft, -- 2
	SceneManager.moveFromBottom, -- 3
	SceneManager.moveFromTop, -- 4
	SceneManager.moveFromRightWithFade, -- 5
	SceneManager.moveFromLeftWithFade, -- 6
	SceneManager.moveFromBottomWithFade, -- 7
	SceneManager.moveFromTopWithFade, -- 8
	SceneManager.overFromRight, -- 9
	SceneManager.overFromLeft, -- 10
	SceneManager.overFromBottom, -- 11
	SceneManager.overFromTop, -- 12
	SceneManager.overFromRightWithFade, -- 13
	SceneManager.overFromLeftWithFade, -- 14
	SceneManager.overFromBottomWithFade, -- 15
	SceneManager.overFromTopWithFade, -- 16
	SceneManager.fade, -- 17
	SceneManager.crossFade, -- 18
	SceneManager.flip, -- 19
	SceneManager.flipWithFade, -- 20
	SceneManager.flipWithShade, -- 21
}
easings = {
	easing.inBack, -- 1
	easing.outBack, -- 2
	easing.inOutBack, -- 3
	easing.inBounce, -- 4
	easing.outBounce, -- 5
	easing.inOutBounce, -- 6
	easing.inCircular, -- 7
	easing.outCircular, -- 8
	easing.inOutCircular, -- 9
	easing.inCubic, -- 10
	easing.outCubic, -- 11
	easing.inOutCubic, -- 12
	easing.inElastic, -- 13
	easing.outElastic, -- 14
	easing.inOutElastic, -- 15
	easing.inExponential, -- 16
	easing.outExponential, -- 17
	easing.inOutExponential, -- 18
	easing.linear, -- 19
	easing.inQuadratic, -- 20
	easing.outQuadratic, -- 21
	easing.inOutQuadratic, -- 22
	easing.inQuartic, -- 23
	easing.outQuartic, -- 24
	easing.inOutQuartic, -- 25
	easing.inQuintic, -- 26
	easing.outQuintic, -- 27
	easing.inOutQuintic, -- 28
	easing.inSine, -- 29
	easing.outSine, -- 30
	easing.inOutSine, -- 31
}
