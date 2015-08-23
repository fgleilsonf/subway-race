local composer = require( "composer" )

local scene = composer.newScene()

function scene:create( event )
    local sceneGroup = self.view

	local xMin = display.screenOriginX
	local yMin = display.screenOriginY
	local xMax = display.contentWidth - display.screenOriginX
	local yMax = display.contentHeight - display.screenOriginY
	local _W = display.contentWidth
	local _H = display.contentHeight

	local background = display.newImageRect("images/background.jpg", xMax-xMin, yMax-yMin)
	background.x = _W * 0.5
	background.y = _H * 0.5

	local sheetData =  { width=45, height=63, numFrames=12 }

	local sheet = graphics.newImageSheet("images/gaara.png", sheetData)

	local sequenceData = 
	{
		{ name = "idleDown", start = 1, count = 1, time = 0, loopCount = 1 },
	    { name = "idleLeft", start = 4, count = 1, time = 0, loopCount = 1 },
	    { name = "idleRight", start = 7, count = 1, time = 0, loopCount = 1 },
	    { name = "idleUp", start = 10, count = 1, time = 0, loopCount = 1 },
	    { name = "moveDown", start = 2, count = 2, time = 300, loopCount = 0 },
	    { name = "moveLeft", start = 5, count = 2, time = 300, loopCount = 0 },
	    { name = "moveRight", start = 8, count = 2, time = 300, loopCount = 0 },
	    { name = "moveUp", start = 11, count = 2, time = 300, loopCount = 0 }
	}

	local player = display.newSprite(sheet, sequenceData)

	player.x = _W * .5
	player.y = _H

	player:setSequence("idleUp")

	local buttons = {}

	buttons[1] = display.newImage("images/button-navegation.png")
	buttons[1].x = 250
	buttons[1].y = 380
	buttons[1].myName = "up"
	buttons[1].rotation = -90

	buttons[2] = display.newImage("images/button-navegation.png")
	buttons[2].x = 250
	buttons[2].y = 440
	buttons[2].myName = "down"
	buttons[2].rotation = 90

	buttons[3] = display.newImage("images/button-navegation.png")
	buttons[3].x = 210
	buttons[3].y = 410
	buttons[3].myName = "left"
	buttons[3].rotation = 180

	buttons[4] = display.newImage("images/button-navegation.png")
	buttons[4].x = 290
	buttons[4].y = 410
	buttons[4].myName = "right"

	local yAxis = 0
	local xAxis = 0

	local touchFunction = function(e)
		local eventName = e.phase
		local direction = e.target.myName
		
		if eventName == "began" or eventName == "moved" then
			if direction == "up" then 
				player:setSequence("moveUp")			

				yAxis = -5
				xAxis = 0
			elseif direction == "down" then 
				player:setSequence("moveDown")

				yAxis = 5
				xAxis = 0
			elseif direction == "right" then
				player:setSequence("moveRight")

				xAxis = 5
				yAxis = 0
			elseif direction == "left" then
				player:setSequence("moveLeft")

				xAxis = -5
				yAxis = 0
			end
		else 
			if e.target.myName == "up" then 
				player:setSequence("idleUp")
			elseif e.target.myName == "down" then 
				player:setSequence("idleDown")
			elseif e.target.myName == "right" then
				player:setSequence("idleRight")
			elseif e.target.myName == "left" then
				player:setSequence("idleLeft")
			end
			
			yAxis = 0
			xAxis = 0
		end
	end

	local j=1

	for j=1, #buttons do 
		buttons[j]:addEventListener("touch", touchFunction)
	end

	local update = function()
		player.x = player.x + xAxis
		player.y = player.y + yAxis

		if player.x <= player.width * .5 then 
			player.x = player.width * .5
		elseif player.x >= _W - player.width * .5 then 
			player.x = _W - player.width * .5
		end

		if player.y <= player.height * .5 then
			player.y = player.height * .5
		elseif player.y >= _H - player.height * .5 then 
			player.y = _H - player.height * .5
		end 
		
		player:play()
	end

	Runtime:addEventListener("enterFrame", update)
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