--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
local helper = require( "helper" )
local slideView = require("Zunware_SlideView")

local scene = composer.newScene()

local centerWidth = display.contentWidth / 2

local xMin = display.screenOriginX
local yMin = display.screenOriginY
local xMax = display.contentWidth - display.screenOriginX
local yMax = display.contentHeight - display.screenOriginY
local _W = display.contentWidth
local _H = display.contentHeight

function scene:create( event )
    local sceneGroup = self.view

    display.setDefault("background", 255, 255, 255, 1)

	local titlePageProfile = createMessage( "Informações", display.contentWidth  * 0.5, 40 )
    sceneGroup:insert(titlePageProfile)

	local msgName = display.newText("Gleilson Ferreira", display.contentWidth * 0.04, 80, native.systemFontBold, 22)
    msgName:setTextColor(0.9, 0.9, 0.9)
    sceneGroup:insert(msgName)

    local msgInfo = display.newText("FA7 - SI: Estágio 1", display.contentWidth * 0.05, 110, native.systemFontBold, 22)
    msgInfo:setTextColor(1, 1, 1)
    sceneGroup:insert(msgInfo)

    local msgProject = display.newText("Projeto: subway-run", display.contentWidth * 0.05, 140, native.systemFontBold, 22)
    msgProject:setTextColor(1, 1, 1)
    sceneGroup:insert(msgProject)

    local msgGithub = display.newText("https://github.com/fgleilsonf", display.contentWidth * 0.05, 170, native.systemFontBold, 21)
    msgGithub:setTextColor(1, 1, 1)
    sceneGroup:insert(msgGithub)

    local btnBackPage = display.newImage( "images/back_pages.png" )
    btnBackPage.x = display.contentWidth * 0.5
    btnBackPage.y = display.contentHeight - 40
    sceneGroup:insert(btnBackPage)

    function btnBackPage:tap()
        composer.gotoScene( "menu" )
    end

    btnBackPage:addEventListener("tap", btnBackPage)
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