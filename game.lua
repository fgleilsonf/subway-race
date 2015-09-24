local composer = require( "composer" )
local scene = composer.newScene()
local audio = require "audio"

function scene:create( event )
    local sceneGroup = self.view

    local xMin = display.screenOriginX
    local yMin = display.screenOriginY
    local xMax = display.contentWidth - display.screenOriginX
    local yMax = display.contentHeight - display.screenOriginY
    local _W = display.contentWidth
    local _H = display.contentHeight
    local _POSITION_PERSON_RIGHT = _W * 0.68
    local _POSITION_PERSON_CENTER = _W * 0.45
    local _POSITION_PERSON_LEFT = _W * 0.19
    local _MOEDA_TIPO_NORMAL = "moeda"
    local _MOEDA_TIPO_MONOTONE = "moedaMonotone"
    local _MOEDA_TIPO_INVALIDA = "moedaInvalida"

    local _MOEDA_LEFT = -53
    local _MOEDA_CENTER = -10
    local _MOEDA_RIGHT = 29

    local countPoints = 0
    local countEstrelaPoints = 0
    local countEstrelaPoints2 = 0

    local addTimePontuacao = {}
    local timerPontuacao

    local TIMER = 1000

    local captureSound = audio.loadSound( "capture.mp3" )
    local gameOverSound = audio.loadSound( "gameover.mp3" )

    local background = display.newImageRect("images/fundo2.jpg", xMax-xMin, yMax-yMin)
    background.myName = "ground"
    background.x = _W * 0.5
    background.y = _H * 0.5
    sceneGroup:insert(background)

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

    local titleGame = createStatusMessage( "Subway Run", display.contentWidth  * 0.5, 25 )
    local pontuacao = createStatusMessage( "0", display.contentWidth  * 0.1, 80 )
    local estrela = createStatusMessage( "0", display.contentWidth - 30, 160 )
    local estrelaMonotone = createStatusMessage( "0", display.contentWidth - 30, 80 )

    sceneGroup:insert(titleGame)
    sceneGroup:insert(pontuacao)
    sceneGroup:insert(estrela)
    sceneGroup:insert(estrelaMonotone)

    function capturaMoeda( obj )
        if (obj.myName == _MOEDA_TIPO_NORMAL) then
            audio.play( captureSound )
            countEstrelaPoints = countEstrelaPoints + 1
            estrela = createStatusMessage(countEstrelaPoints, estrela.x, estrela.y)
        elseif (obj.myName == _MOEDA_TIPO_MONOTONE) then
            audio.play( captureSound )
            countEstrelaPoints2 = countEstrelaPoints2 + 1
            estrelaMonotone = createStatusMessage(countEstrelaPoints2, estrelaMonotone.x, estrelaMonotone.y)
        else
            audio.play( gameOverSound )
            timer.cancel(timerPontuacao)
            -- sceneGroup:insert(pontuacao)
            -- sceneGroup:insert(estrela)
            -- sceneGroup:insert(estrelaMonotone)
            scene:destroy()
            composer.gotoScene( "gameover" )
        end

        setData()
    end

    function addTimePontuacao:timer( event )
        countPoints = countPoints + 1
        pontuacao = createStatusMessage(countPoints, pontuacao.x, pontuacao.y)

        setData()
    end

    timerPontuacao = timer.performWithDelay( 1000, addTimePontuacao, 0 )

    local trilho = display.newImage( "images/trilhos.jpg" )
    trilho.x = _W * 0.19
    trilho.y = _H - 570
    trilho.height = _H + 1500
    trilho.width = _W + 40
    trilho.path.x1 = 240
    trilho.path.x3 = 50
    trilho.path.y1 = 1200
    trilho.path.y4 = 1200

    sceneGroup:insert(trilho)

    local trilho1 = display.newImage( "images/trilhos.jpg" )
    trilho1.x = _W * 0.19
    trilho1.y = _H - 570
    trilho1.height = _H + 1500
    trilho1.width = _W + 40
    trilho1.path.x1 = 240
    trilho1.path.x3 = 50
    trilho1.path.y1 = 1200
    trilho1.path.y4 = 1200

    sceneGroup:insert(trilho1)

    local trilho2 = display.newImage( "images/trilhos.jpg" )
    trilho2.x = _W * 0.19
    trilho2.y = _H - 565
    trilho2.height = _H + 1500
    trilho2.width = _W + 40
    trilho2.path.x1 = 240
    trilho2.path.x3 = 50
    trilho2.path.y1 = 1200
    trilho2.path.y4 = 1200
    trilho2.isVisible = false

    sceneGroup:insert(trilho2)

    local trilho3 = display.newImage( "images/trilhos.jpg" )
    trilho3.x = _W * 0.19
    trilho3.y = _H - 560
    trilho3.height = _H + 1500
    trilho3.width = _W + 40
    trilho3.path.x1 = 240
    trilho3.path.x3 = 50
    trilho3.path.y1 = 1200
    trilho3.path.y4 = 1200
    trilho3.isVisible = false


    sceneGroup:insert(trilho3)

    -- function fnLoadTrilho2( )
    --     trilho2.isVisible = false
    --     transition.to(trilho3, { time=2000, y = _H - 550, onComplete=fnLoadTrilho2 } ) 
    -- end

    function fnLoadTrilho( )
        
        transition.to(trilho1, { time=2000, y = _H - 530 } ) 
    end

    -- transition.to(trilho1, { time=1000, y = _H - 550, onComplete=fnLoadTrilho } ) 

    local moedaPontuacao = display.newImage( "images/moeda.png" )
    moedaPontuacao.x = 290
    moedaPontuacao.path.y1 = 30
    moedaPontuacao.path.y2 = 30
    moedaPontuacao.path.y3 = 30
    moedaPontuacao.path.y4 = 30
    moedaPontuacao.fill.effect = "filter.monotone"
    moedaPontuacao.fill.effect.r = 1
    moedaPontuacao.fill.effect.g = 0.2
    moedaPontuacao.fill.effect.b = 0
    moedaPontuacao.fill.effect.a = 1
    sceneGroup:insert(moedaPontuacao)

    local moedaPontuacao2 = display.newImage( "images/moeda.png" )
    moedaPontuacao2.x = 290
    moedaPontuacao2.path.y1 = 110
    moedaPontuacao2.path.y2 = 110
    moedaPontuacao2.path.y3 = 110
    moedaPontuacao2.path.y4 = 110
    sceneGroup:insert(moedaPontuacao2)

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
    spriteInstance.myName = "sprite"
    spriteInstance.x = _POSITION_PERSON_CENTER
    spriteInstance.y = _H - 40
    sceneGroup:insert(spriteInstance)

    spriteInstance:setSequence("idleUp")

    local multiplo = 4;

    function checkSwipeDirection()
        if beginSwipeX > endSwipeX then
            if (math.floor(spriteInstance.x) == math.floor(_POSITION_PERSON_CENTER)) then 
                transition.to( spriteInstance, { x =  _POSITION_PERSON_LEFT,  time=400 } )
            elseif (math.floor(spriteInstance.x) == math.floor(_POSITION_PERSON_RIGHT)) then                 
                transition.to( spriteInstance, { x =  _POSITION_PERSON_CENTER,  time=400 } )
            end
        elseif (endSwipeX > beginSwipeX) then
            if (math.floor(spriteInstance.x) == math.floor(_POSITION_PERSON_LEFT)) then 
                transition.to( spriteInstance, { x =  _POSITION_PERSON_CENTER,  time=400 } )    
            elseif (math.floor(spriteInstance.x) == math.floor(_POSITION_PERSON_CENTER)) then    
                transition.to( spriteInstance, { x =  _POSITION_PERSON_RIGHT,  time=400 } )
            end
        else
            print("Apenas clicou")
        end
    end

    function swipe(event)
        if event.phase == "began" then
            beginSwipeX = event.x
        end
        if event.phase == "ended" then
            endSwipeX = event.x
            checkSwipeDirection()
        end
    end

    Runtime:addEventListener("touch", swipe)

    print("_H", _H)

    local multiplo = 4

    function fnMoveMoeda11(object)
        print("FINISH")
    end

    function fnMoveMoeda10(object)
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 210, 
            onComplete = function(object)
                fnMoveMoeda11(object)
            end 
        })
    end

    function fnMoveMoeda9(object)
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 240, 
            onComplete = function(object)
                fnMoveMoeda10(object) 
            end    
        })    
    end

    function fnMoveMoeda8(object)
        object.x = object.x - multiplo
        transition.to(object, { 
            time = TIMER, 
            y = _H - 270, 
            onComplete = function(object)
                fnMoveMoeda9(object) 
            end
        })    
    end

    function fnMoveMoeda7(object)
        print("fnMoveMoeda7 Objeto", object);
        print("loadTransitionMoeda Objeto.y", object.y);
        object.x = object.x - multiplo
        transition.to(object, { 
            time = TIMER, 
            y = _H - 300, 
            onComplete = function(object) 
                fnMoveMoeda8(object)
            end
        })    
    end

    function fnMoveMoeda6(object)
        print("fnMoveMoeda6 Objeto", object);
        print("loadTransitionMoeda Objeto.y", object.y);
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 330, 
            onComplete = function(object) 
                fnMoveMoeda7(object) 
            end
        })    
    end

    function fnMoveMoeda5(object)
        print("fnMoveMoeda5 Objeto", object);
        print("loadTransitionMoeda Objeto.y", object.y);
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 360, 
            onComplete = function(object) 
                fnMoveMoeda6(object) 
            end
        })    
    end

    function fnMoveMoeda4(object)
        print("fnMoveMoeda4 Objeto", object);
        print("loadTransitionMoeda Objeto.y", object.y);
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 390, 
            onComplete = function (object)
                fnMoveMoeda5(object)
            end
        })    
    end

    function fnMoveMoeda3(object)
        print("fnMoveMoeda3 Objeto", object);
        print("loadTransitionMoeda Objeto.y", object.y);
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 420, 
            onComplete = function (object) 
                fnMoveMoeda4(object)
            end
        })    
    end

    function fnMoveMoeda2(object)
        print("fnMoveMoeda2 Objeto", object);
        print("loadTransitionMoeda Objeto.y", object.y);
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 450, 
            onComplete = function(object) 
                fnMoveMoeda3(object) 
            end
        })    
    end

    function fnMoveMoeda(object)
        print("fnMoveMoeda Objeto", object);
        print("loadTransitionMoeda Objeto.y", object.y);
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 480, 
            onComplete = function(object)  
                fnMoveMoeda2(object) 
            end
        })    
    end

    function loadTransitionMoeda(object) 
        print("loadTransitionMoeda Objeto", object);
        print("loadTransitionMoeda Objeto.y", object.y);
        transition.to(object, {
            time=TIMER, 
            y = _H - 510, 
            onComplete = function(object)  
                fnMoveMoeda(object)  
            end
        })
    end

    function createMoeda(position, tipo)
        local objectMoeda = display.newImage( "images/moeda.png" )
        objectMoeda.myName = tipo
        objectMoeda.x = position
        objectMoeda.y = _H - 540
        objectMoeda.path.x1 = 190
        objectMoeda.path.x2 = 190
        objectMoeda.path.x3 = 190
        objectMoeda.path.x4 = 190
        objectMoeda.path.y1 = 190
        objectMoeda.path.y2 = 190
        objectMoeda.path.y3 = 190
        objectMoeda.path.y4 = 190

        if (tipo == _MOEDA_TIPO_MONOTONE) then
            objectMoeda.fill.effect = "filter.monotone"
            objectMoeda.fill.effect.r = 1
            objectMoeda.fill.effect.g = 0.2
            objectMoeda.fill.effect.b = 0
            objectMoeda.fill.effect.a = 1 
        elseif (tipo == _MOEDA_TIPO_INVALIDA) then
            objectMoeda.fill.effect = "filter.monotone"
        end

        return objectMoeda
    end

    local function addTimeCreateMoeda( event )

        local sorteio = math.random(3)
        local sorteio2 = math.random(3)

        local tipoMoeda = _MOEDA_TIPO_NORMAL
        if (sorteio2 == 2) then
            tipoMoeda =_MOEDA_TIPO_MONOTONE
        elseif (sorteio2 == 3) then
            tipoMoeda =_MOEDA_TIPO_INVALIDA
        end

        if (sorteio == 1) then
            local moeda = createMoeda(_MOEDA_LEFT, tipoMoeda)
            loadTransitionMoeda(moeda, _POSITION_PERSON_LEFT) 
            sceneGroup:insert(moeda)
        elseif (sorteio == 2) then
            local moeda = createMoeda(_MOEDA_CENTER, tipoMoeda)
            loadTransitionMoeda(moeda, _POSITION_PERSON_CENTER)
            sceneGroup:insert(moeda)
        else
            local moeda = createMoeda(_MOEDA_RIGHT, tipoMoeda)
            loadTransitionMoeda(moeda, _POSITION_PERSON_RIGHT)
            sceneGroup:insert(moeda)
        end 
    end

    -- timer.performWithDelay( 2000, addTimeCreateMoeda, 0 )

    local objectMoeda1 = display.newImage( "images/moeda.png" )
    objectMoeda1.myName = _MOEDA_TIPO_MONOTONE
    objectMoeda1.x = _MOEDA_LEFT
    objectMoeda1.y = _H - 540
    objectMoeda1.path.x1 = 190
    objectMoeda1.path.x2 = 190
    objectMoeda1.path.x3 = 190
    objectMoeda1.path.x4 = 190
    objectMoeda1.path.y1 = 190
    objectMoeda1.path.y2 = 190
    objectMoeda1.path.y3 = 190
    objectMoeda1.path.y4 = 190

    local objectMoeda2 = display.newImage( "images/moeda.png" )
    objectMoeda2.myName = _MOEDA_TIPO_MONOTONE
    objectMoeda2.x = _MOEDA_CENTER
    objectMoeda2.y = _H - 540
    objectMoeda2.path.x1 = 190
    objectMoeda2.path.x2 = 190
    objectMoeda2.path.x3 = 190
    objectMoeda2.path.x4 = 190
    objectMoeda2.path.y1 = 190
    objectMoeda2.path.y2 = 190
    objectMoeda2.path.y3 = 190
    objectMoeda2.path.y4 = 190

    loadTransitionMoeda(objectMoeda1) 
    loadTransitionMoeda(objectMoeda2) 

    function setData()
        composer.setVariable( "timer", countPoints )
        composer.setVariable( "quantEstrelaNormal", countEstrelaPoints )
        composer.setVariable( "quantEstrela", countEstrelaPoints2 )
    end

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