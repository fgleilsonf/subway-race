local composer = require( "composer" )
local scene = composer.newScene()

local widget = require "widget"

function scene:create( event )
	local sceneGroup = self.view

	local title = display.newText( "Subway Run", 100, 200, "Verdana", 24 )
	title.x = display.contentWidth  * 0.5
	title.y = 100

	local imagePlay = display.newImage( "play.png" )
	imagePlay.x = display.contentWidth / 2
	imagePlay.y = display.contentHeight / 2
	imagePlay.width = 48
    imagePlay.height = 48

	local myImage = display.newImage( "face.png" )
	myImage.x = display.contentWidth / 2
	myImage.y = display.contentHeight - 80
	myImage.width = 48
    myImage.height = 48
    myImage.visible = false

    function imagePlay:tap(event)
		composer.gotoScene( "scene1", "fade", 500 )
	end
	imagePlay:addEventListener("tap", imagePlay)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	elseif phase == "did" then
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
	elseif phase == "did" then
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	if myImage then
		myImage:removeSelf()
		myImage = nil
	end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene