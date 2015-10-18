--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require "widget"
local facebook = require("facebook")
local json = require("json")

local helper = require( "helper" )

function scene:create( event )
	local sceneGroup = self.view

	local xMin = display.screenOriginX
    local yMin = display.screenOriginY
    local xMax = display.contentWidth - display.screenOriginX
    local yMax = display.contentHeight - display.screenOriginY
    local _W = display.contentWidth
    local _H = display.contentHeight

	local background = display.newImageRect("images/background-pages.jpg", xMax-xMin, yMax-yMin)
	background.x = _W * 0.5
	background.y = _H * 0.5
    sceneGroup:insert(background)

	local titleGame = createMessage( "Subway Run", display.contentWidth  * 0.5, 40 )
	sceneGroup:insert(titleGame)

    local centerX = display.contentCenterX
    local y = display.contentHeight - 250

    local msgGameOver = createMessage( "Game Over", centerX,  display.contentHeight * 0.5)
    sceneGroup:insert(msgGameOver)

	local timer = composer.getVariable( "timer" )
	local quantEstrelaNormal = composer.getVariable( "quantEstrelaNormal" )
	local quantEstrela = composer.getVariable( "quantEstrela" )

	local sumTotal = timer + (quantEstrelaNormal * 5) + (quantEstrela * 10)

	local pontuacao = createMessage( "pontuação: "..sumTotal, display.contentWidth  * 0.5, 300 )
	sceneGroup:insert(pontuacao)

    local btnBackPage = display.newImage( "images/play_again.png" )
    btnBackPage.x = display.contentWidth * 0.5
    btnBackPage.y = display.contentHeight - 40
    sceneGroup:insert(btnBackPage)

    function btnBackPage:tap()
    	composer.removeScene( "gameover" )
        composer.gotoScene( "game" )
    end

    btnBackPage:addEventListener("tap", btnBackPage)
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