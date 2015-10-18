--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
local scene = composer.newScene()
local helper = require( "helper" )

local widget = require( "widget" ) require ( "sqlite3" )
local facebook = require("facebook")
local json = require("json")

function scene:create( event )
	local sceneGroup = self.view

	local xMin = display.screenOriginX
    local yMin = display.screenOriginY
    local xMax = display.contentWidth - display.screenOriginX
    local yMax = display.contentHeight - display.screenOriginY
    local _W = display.contentWidth
    local _H = display.contentHeight

    local background = display.newImageRect("images/background-pages.jpg", xMax-xMin, yMax-yMin)
    background.myName = "ground"
    background.x = _W * 0.5
    background.y = _H * 0.5
    sceneGroup:insert(background)

	local titleGame = createMessage( "Subway Run", display.contentWidth  * 0.5, 100 )
	sceneGroup:insert(titleGame)

	-- gatilho para eventos "fbconnect"
	local function listener( event )
	if ( "session" == event.type ) then
	-- depois de um login bem sucedido, requisita a	lista de amigos do usuário autenticado
	if ( "login" == event.phase ) then
		facebook.request( "me/friends" )
	end
	elseif ( "request" == event.type ) then
		local titleGame = createMessage( "Respondendo", display.contentWidth  * 0.5, 400 )
		local titleGame2 = createMessage( event.type, display.contentWidth  * 0.5, 240 )
		-- event.response é um objeto JSON do servidor FB
		local response = event.response
		-- se a requisição é bem sucedida, cria uma lista rolável de nomes de amigos
		if ( not event.isError ) then
			response = json.decode( event.response )
			
			local titleGame4 = createMessage( "Pegar dados", display.contentWidth  * 0.5, 260 )

			local data = response.data
			local x = 220
			local title2 = {}
			for i=1,#data do
				local name = data[i].name
				title56 = createMessage( i, display.contentWidth  * 0.5, 250 )
				print( name )
				local title2 = createMessage( name, display.contentWidth  * 0.5, x )
				x = x + 20
			end
		end
		elseif ( "dialog" == event.type ) then
			print( "dialog", event.response )
		end
	end

	local appId = "896263840455584"
	facebook.login( appId, listener )


    -- local function onRowRender( event )
    -- 	local row = event.row

    -- 	local rowHeight = row.contentHeight
    -- 	local rowWidth = row.contentWidth

    -- 	local rowTitle = display.newText(row, "Row "..row.index, 0, 0, nil, 14)
    -- 	rowTitle:setFillColor( 0 )

    -- 	rowTitle.anchorX = 0
    -- 	rowTitle.x = 0
    -- 	rowTitle.y = rowHeight * 0.5
    -- end

 --    local path = system.pathForFile("data.db", system.DocumentsDirectory)
 --    local db = sqlite3.open( path )

 --     local table_options = {
 --    	top = 0,
 --    	onRowRender = onRowRender
	-- } 

	-- local facebook = require "facebook"
	-- -- gatilho para eventos "fbconnect"
	-- local function listener( event )
	-- if ( "session" == event.type ) then
	-- -- depois de um login bem sucedido, requisita a
	-- --lista de amigos do usuário autenticado
	-- if ( "login" == event.phase ) then
	-- 	facebook.request( "me/friends" )
	-- end
	-- elseif ( "request" == event.type ) then
	-- 	-- event.response é um objeto JSON do servidor FB
	-- 	local response = event.response
	-- 	local titleGame = createMessage( "Respondendo", display.contentWidth  * 0.5, 400 )
	-- 	-- se a requisição é bem sucedida, cria uma lista
	-- 	--rolável de nomes de amigos
	-- 	if ( not event.isError ) then
	-- 		response = json.decode( event.response )
	-- 		local data = response.data
	-- 		local x = 200
	-- 		for i=1,#data do
	-- 			local name = data[i].name
	-- 			print( name )

	-- 			local title2 = createMessage( name, display.contentWidth  * 0.5, x )
	-- 			x = x + 20
	-- 		end
	-- 	elseif ( "dialog" == event.type ) then
	-- 		local titleGame = createMessage( event.response, display.contentWidth  * 0.5, 230 )
	-- 		print( "dialog", event.response )
	-- 	else 	
	-- 		local titleGame = createMessage( event.type, display.contentWidth  * 0.5, 230 )
	-- 	end
	-- end

	-- local appId  = "896263840455584"
	-- facebook.login( appId, listener)
    -- local tableView = widget.newTableView( table_options )
   
   	-- for row in db:nrows("SELECT * FROM test") do
   	-- 	local rowParams = {
	   -- 		ID = row.id,
	   -- 		Name = row.name
	   -- 	}

	   -- 	tableView:insertRow(
	   -- 		{
	   -- 		 rowHeight = 50,
	   -- 		 params = rowParams
   	-- 		}
   	-- 	)
   	-- end

	local btnStartGame = display.newImage( "images/startGame.png" )
	btnStartGame.x = display.contentWidth / 2
	btnStartGame.y = display.contentHeight / 2
	sceneGroup:insert(btnStartGame)

	local btnFacebook = display.newImage( "images/face.png" )
	btnFacebook.x = display.contentWidth / 2
	btnFacebook.y = display.contentHeight - 90
	btnFacebook.width = 48
    btnFacebook.height = 48
	sceneGroup:insert(btnFacebook)

    local btnInfo = display.newImage( "images/info.png" )
	btnInfo.x = display.contentWidth * 0.8
	btnInfo.y = display.contentHeight - 90
	btnInfo.width = 48
    btnInfo.height = 48
	sceneGroup:insert(btnInfo)

    local btnHelp = display.newImage( "images/help.png" )
	btnHelp.x = display.contentWidth * 0.2
	btnHelp.y = display.contentHeight - 90
	btnHelp.width = 48
    btnHelp.height = 48
	sceneGroup:insert(btnHelp)

    local centerX = display.contentCenterX
    local y = display.contentHeight - 30
    local labelStatusConectedFacebook = createMessage( "Não conectado", centerX,  y)
    sceneGroup:insert(labelStatusConectedFacebook)

 --    function listener(event)
 --    	if ( "session" == event.type ) then
 --    		statusMessage.textObject.text = event.phase
	-- 		facebook.request( "me" )
 --    	elseif ( "request" == event.type ) then
	--         local response = event.response
	        
	-- 		if ( not event.isError ) then
	-- 	        response = json.decode( event.response )
	-- 			statusMessage.textObject.text = response.name
	-- 		else
	-- 			statusMessage.textObject.text = "Desconhecido"
	-- 		end
	-- 	end
 --    end

	-- function btnFacebook:tap(event)
	-- 	local appId  = "896263840455584"
	-- 	facebook.login( appId, listener, {"publish_actions"} )
	-- end

    function btnStartGame:tap(event)
		composer.gotoScene( "game" )
	end

	function btnInfo:tap(event)
		composer.gotoScene( "info" )
	end

	function btnHelp:tap(event)
		composer.gotoScene( "tutorial" )
	end
	
	btnStartGame:addEventListener("tap", btnStartGame)
	btnInfo:addEventListener("tap", btnInfo)
	btnFacebook:addEventListener("tap", btnFacebook)
	btnHelp:addEventListener("tap", btnHelp)
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