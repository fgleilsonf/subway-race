local composer = require( "composer" )
local scene = composer.newScene()

local widget = require "widget"
local facebook = require("facebook")
local json = require("json")

local function createStatusMessage( message, x, y )
	local textObject = display.newText( message, 0, 0, native.systemFontBold, 24 )
	textObject:setFillColor( 1,1,1 )

	local group = display.newGroup()
	group.x = x
	group.y = y
	group:insert( textObject, true )

	local r = 10
	local roundedRect = display.newRoundedRect( 0, 0, textObject.contentWidth + 2*r, textObject.contentHeight + 2*r, r )
	group:insert( 1, roundedRect, true )

	group.textObject = textObject
	return group
end

function scene:create( event )
	local sceneGroup = self.view

	local statusMessage = createStatusMessage( "Subway Run", display.contentWidth  * 0.5, 100 )

	local imagePlay = display.newImage( "images/play.png" )
	imagePlay.x = display.contentWidth / 2
	imagePlay.y = display.contentHeight / 2
	imagePlay.width = 48
    imagePlay.height = 48

	local btnFacebook = display.newImage( "images/face.png" )
	btnFacebook.x = display.contentWidth / 2
	btnFacebook.y = display.contentHeight - 90
	btnFacebook.width = 48
    btnFacebook.height = 48
    btnFacebook.visible = false

    local centerX = display.contentCenterX
    local StatusMessageY = display.contentHeight - 30

    local statusMessage = createStatusMessage( "Não conectado", centerX, StatusMessageY )

    function listener(event)
    	if ( "session" == event.type ) then
    		statusMessage.textObject.text = event.phase
			facebook.request( "me" )
    	elseif ( "request" == event.type ) then
	        local response = event.response
	        
			if ( not event.isError ) then
		        response = json.decode( event.response )
				statusMessage.textObject.text = response.name
			else
				statusMessage.textObject.text = "Desconhecido"
			end
		end
    end

	function btnFacebook:tap(event)
		local appId  = "896263840455584"
		facebook.login( appId, listener, {"publish_actions"} )
	end


    function imagePlay:tap(event)
		composer.gotoScene( "scene1", "fade", 500 )
	end
	imagePlay:addEventListener("tap", imagePlay)
	btnFacebook:addEventListener("tap", btnFacebook)

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