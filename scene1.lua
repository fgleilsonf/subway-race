
local composer = require( "composer" )

local scene = composer.newScene()

local xMin = display.screenOriginX
local yMin = display.screenOriginY
local xMax = display.contentWidth - display.screenOriginX
local yMax = display.contentHeight - display.screenOriginY
local _W = display.contentWidth
local _H = display.contentHeight

function scene:create( event )
    local sceneGroup = self.view
	-- local background = display.newImageRect("images/fundo.jpg", xMax-xMin, yMax-yMin)
	-- background.x = _W * 0.5
	-- background.y = _H * 0.5

	local trilho1 = display.newImage( "images/trilhos.jpg" )
	trilho1.x = _W * 0.2
	trilho1.y = _H - 200
	trilho1.height = _H
	trilho1.width = _W
	trilho1.path.x1 = 250
	trilho1.path.x2 = 120
	trilho1.path.x3 = 90
	trilho1.path.y1 = 200
	trilho1.path.y4 = 200

	local moeda = display.newImage( "images/moeda.png" )
	moeda.x = -25
	moeda.y = _H - 400
	moeda.path.x1 = 190
	moeda.path.x2 = 190
	moeda.path.x3 = 190
	moeda.path.x4 = 190
	moeda.path.y1 = 190
	moeda.path.y2 = 190
	moeda.path.y3 = 190
	moeda.path.y4 = 190

	local moeda = display.newImage( "images/moeda.png" )
	moeda.x = -80
	moeda.y = _H - 340
	moeda.path.x1 = 190
	moeda.path.x2 = 190
	moeda.path.x3 = 190
	moeda.path.x4 = 190
	moeda.path.y1 = 190
	moeda.path.y2 = 190
	moeda.path.y3 = 190
	moeda.path.y4 = 190
	moeda.fill.effect = "filter.monotone"
	moeda.fill.effect.r = 1
	moeda.fill.effect.g = 0.2
	moeda.fill.effect.b = 0
	moeda.fill.effect.a = 1
	
	local sheetData =  { width=45, height=63, numFrames=12 }
	local spriteOptions = { name="gaara", start=1, count=12, time=300 } 
	local sheet = graphics.newImageSheet("images/gaara.png", sheetData)

	local sequenceData = 
	{
		{ name = "idleDown", start = 1, count = 1, time = 3000, loopCount = 1 },
	    { name = "idleLeft", start = 4, count = 1, time = 3000, loopCount = 1 },
	    { name = "idleRight", start = 7, count = 1, time = 3000, loopCount = 1 },
	    { name = "idleUp", start = 10, count = 1, time = 3000, loopCount = 1 },
	    { name = "moveDown", start = 2, count = 2, time = 3000, loopCount = 0 },
	    { name = "moveLeft", start = 5, count = 2, time = 3000, loopCount = 0 },
	    { name = "moveRight", start = 8, count = 2, time = 3000, loopCount = 0 },
	    { name = "moveUp", start = 11, count = 2, time = 3000, loopCount = 0 },
	}

	local spriteInstance = display.newSprite(sheet, sequenceData)
	spriteInstance.x = _W * 0.5
	spriteInstance.y = _H - 30

	spriteInstance:setSequence("idleUp")

	local TIMER = 4000
	local tamanho = 5
	local value = 180

	transition.to(trilho1, { time=TIMER, y = _H - 80 } )
	transition.to(trilho2, { time=8000, y = _H - 80 } )

end 

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( event.phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene