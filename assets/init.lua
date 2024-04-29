-- plugins
require "scenemanager"
require "easing"

-- app
myappleft, myapptop, myappright, myappbot = application:getLogicalBounds()
myappwidth, myappheight = myappright - myappleft, myappbot - myapptop
ismyappfullscreen = false

-- ttf fonts
myttf = TTFont.new("fonts/Cabin-Regular-TTF.ttf", 2.8*8) -- UI
myttf2 = TTFont.new("fonts/Cabin-Regular-TTF.ttf", 1.5*8) -- HUD

-- global bg
g_bgimg = Bitmap.new(Texture.new("gfx/levels/beu_lvl1/beu_bg_lvl1_0001.png", false))
g_bgimg:setAnchorPoint(0.5, 0.5)
g_bgimg:setPosition(myappwidth/2, myappheight/2)
stage:addChild(g_bgimg)

-- global ui theme
g_ui_theme = {}
g_ui_theme.pixelcolorup = 0x8d595d
g_ui_theme.pixelcolordown = 0xc09c98
g_ui_theme.textcolorup = 0xd9d2cb
g_ui_theme.textcolordown = 0xd9d2cb
g_ui_theme._textcolordisabled = 0xd9d2cb
g_ui_theme.tooltiptextcolor = 0x3a1d20
g_ui_theme.tooltipoffsetx = -7*8
g_ui_theme.tooltipoffsety = 1*4

-- windows title and position
if (application:getDeviceInfo() == "Windows" or application:getDeviceInfo() == "Win32") then
	if not application:isPlayerMode() then
		local sw, sh = application:get("screenSize") -- the user screen size
		application:set("windowTitle", "GIDEROS BEAT'EM UP TECS")
		application:set("windowPosition", (sw - myappwidth) * 0.5, (sh - myappheight) * 0.4)
	end
end





