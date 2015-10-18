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

	local background = display.newImageRect("images/background-pages.jpg", xMax-xMin, yMax-yMin)
	background.x = _W * 0.5
	background.y = _H * 0.5
    sceneGroup:insert(background)

    local titlePageTutotial = createMessage( "Tutorial", display.contentWidth  * 0.5, 40 )
    sceneGroup:insert(titlePageTutotial)

    local images = {
        "images/tutorial/menu.png",
        "images/tutorial/game.png",
        "images/tutorial/gameover.png"
    }

    local slideImages = slideView.new(images, nil)
    sceneGroup:insert(slideImages)

    local btnPrev = display.newImage( "images/circle_back_arrow.png" )
    btnPrev.x = display.contentWidth * 0.1
    btnPrev.y = display.contentHeight / 2
    sceneGroup:insert(btnPrev)

    local btnNext = display.newImage( "images/circle_next_arrow.png" )
    btnNext.x = display.contentWidth * 0.9
    btnNext.y = display.contentHeight / 2
    sceneGroup:insert(btnNext)

    local btnBackPage = display.newImage( "images/back_pages.png" )
    btnBackPage.x = display.contentWidth * 0.5
    btnBackPage.y = display.contentHeight - 40
    sceneGroup:insert(btnBackPage)

    function btnPrev:tap(event)
        if (slideImages.imgNum > 1) then
            slideImages:prevImage()
        end
    end

    function btnNext:tap(event)
        if (slideImages.imgNum <  #images) then
            slideImages:nextImage()
        end
    end

    function btnBackPage:tap()
        composer.gotoScene( "menu" )
    end

    btnPrev:addEventListener("tap", btnPrev)
    btnNext:addEventListener("tap", btnNext)
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