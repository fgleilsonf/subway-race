
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

	local titleGame = createStatusMessage( "Subway Run", display.contentWidth  * 0.5, 100 )

	local btnStartGame = display.newImage( "images/play.png" )
	btnStartGame.x = display.contentWidth / 2
	btnStartGame.y = display.contentHeight / 2
	btnStartGame.width = 48
    btnStartGame.height = 48

    local centerX = display.contentCenterX
    local y = display.contentHeight - 250
    local labelStatusConectedFacebook = createStatusMessage( "Game Over", centerX,  y)

    function btnStartGame:tap(event)
		composer.gotoScene( "game", "fade", 800 )
	end
	btnStartGame:addEventListener("tap", btnStartGame)

	local timer = composer.getVariable( "timer" )
	local quantEstrelaNormal = composer.getVariable( "quantEstrelaNormal" )
	local quantEstrela = composer.getVariable( "quantEstrela" )

	local pontuacao = createStatusMessage( "pontuação: "..timer, display.contentWidth  * 0.5, 300 )
	local estrelaNormal = createStatusMessage( "Estrela normal: "..quantEstrelaNormal, display.contentWidth  * 0.5, 355 )
	local estrela = createStatusMessage( "Estrela: "..quantEstrela, display.contentWidth  * 0.5, 410 )

	sceneGroup:insert(titleGame)
	sceneGroup:insert(btnStartGame)
	sceneGroup:insert(labelStatusConectedFacebook)
	sceneGroup:insert(pontuacao)
	sceneGroup:insert(estrelaNormal)
	sceneGroup:insert(estrela)
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