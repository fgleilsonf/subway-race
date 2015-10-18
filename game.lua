--[[
    @author Gleilson Ferreira
]]

local composer = require( "composer" )
local scene = composer.newScene()
local audio = require "audio"
local helper = require( "helper" )

function scene:create( event )
    local sceneGroup = self.view

    local xMin = display.screenOriginX
    local yMin = display.screenOriginY
    local xMax = display.contentWidth - display.screenOriginX
    local yMax = display.contentHeight - display.screenOriginY
    local _W = display.contentWidth
    local _H = display.contentHeight

    local _POSITION_PERSON_RIGHT = _W * 0.71
    local _POSITION_PERSON_CENTER = _W * 0.45
    local _POSITION_PERSON_LEFT = _W * 0.18

    local _MOEDA_TIPO_NORMAL = "moeda"
    local _MOEDA_TIPO_MONOTONE = "moedaMonotone"
    local _MOEDA_TIPO_INVALIDA = "moedaInvalida"

    local CENTER = "center"
    local LEFT = "left"
    local RIGHT = "right"

    local _MOEDA_LEFT = -54
    local _MOEDA_CENTER = -5
    local _MOEDA_RIGHT = 40

    local countPoints = 0
    local countEstrelaPoints = 0
    local countEstrelaPoints2 = 0

    local addTimeCreateMoeda = {}
    local addTimePontuacao = {}
    local timeCreateMoeda
    local timerPontuacao

    local TIMER = 1000

    local captureSound = audio.loadSound( "audios/capture.mp3" )
    local gameOverSound = audio.loadSound( "audios/gameover.mp3" )

    local background = display.newImageRect("images/fundo2.jpg", xMax-xMin, yMax-yMin)
    background.myName = "ground"
    background.x = _W * 0.5
    background.y = _H * 0.5
    sceneGroup:insert(background)

    local titleGame = createMessage( "Subway Run", display.contentWidth  * 0.5, 30 )
    local pontuacao = createMessage( "0", display.contentWidth  * 0.12, 80 )
    local estrela = createMessage( "0", display.contentWidth - 30, 160 )
    local estrelaMonotone = createMessage( "0", display.contentWidth - 30, 80 )

    sceneGroup:insert(titleGame)
    sceneGroup:insert(pontuacao)
    sceneGroup:insert(estrela)
    sceneGroup:insert(estrelaMonotone)

    function capturaMoeda( obj )
        if (obj.myName == _MOEDA_TIPO_NORMAL) then
            audio.play( captureSound )
            countEstrelaPoints = countEstrelaPoints + 1
            estrela.textObject.text = countEstrelaPoints
        elseif (obj.myName == _MOEDA_TIPO_MONOTONE) then
            audio.play( captureSound )
            countEstrelaPoints2 = countEstrelaPoints2 + 1
            estrelaMonotone.textObject.text = countEstrelaPoints2
        else
            audio.play( gameOverSound )
            timer.cancel(timerPontuacao)
            timer.cancel(timeCreateMoeda)
            sceneGroup:insert(pontuacao)
            sceneGroup:insert(estrela)
            sceneGroup:insert(estrelaMonotone)
            composer.removeScene( "game" )
            composer.gotoScene( "gameover" )
        end

        setData()
    end

    function addTimePontuacao:timer( event )
        countPoints = countPoints + 1
        pontuacao.textObject.text = countPoints

        setData()
    end    

    local trilho = display.newImage( "images/trilhos.jpg" )
    trilho.x = _W * 0.2
    trilho.y = _H - 570
    trilho.height = _H + 1500
    trilho.width = _W + 60
    trilho.path.x1 = 240
    trilho.path.x3 = 50
    trilho.path.y1 = 1200
    trilho.path.y4 = 1200

    sceneGroup:insert(trilho)

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

    local multiplo = 4

    function checkSwipeDirection()
        local distance =  endSwipeX - beginSwipeX
        if distance < 0 then
            if (math.floor(spriteInstance.x) == math.floor(_POSITION_PERSON_CENTER)) then 
                transition.to( spriteInstance, { x =  _POSITION_PERSON_LEFT,  time=400 } )
            elseif (math.floor(spriteInstance.x) == math.floor(_POSITION_PERSON_RIGHT)) then                 
                transition.to( spriteInstance, { x =  _POSITION_PERSON_CENTER,  time=400 } )
            end
        elseif distance > 0 then
            if (math.floor(spriteInstance.x) == math.floor(_POSITION_PERSON_LEFT)) then 
                transition.to( spriteInstance, { x =  _POSITION_PERSON_CENTER,  time=400 } )    
            elseif (math.floor(spriteInstance.x) == math.floor(_POSITION_PERSON_CENTER)) then    
                transition.to( spriteInstance, { x =  _POSITION_PERSON_RIGHT,  time=400 } )
            end
        else
            print("Apenas clicou")
        end
    end

    local swipe = function (event)
        if event.phase == "began" then
            beginSwipeX = event.x
        end
        if event.phase == "ended" then
            endSwipeX = event.x
            checkSwipeDirection()
        end
    end

    function getPositionSprit()
        local positionX = math.floor(spriteInstance.x)
        if (math.floor(_POSITION_PERSON_RIGHT) == positionX) then
            return RIGHT;
        elseif (math.floor(_POSITION_PERSON_LEFT) == positionX) then
            return LEFT;
        else 
            return CENTER;
        end
    end

    function fnMoveMoeda11(object, colision, multiplo)
        print("Sprint", getPositionSprit())
        print("Moeda", colision)
        if (getPositionSprit() == colision) then
            object.isVisible = false
            capturaMoeda(object, colision, multiplo)
        else 
            print("Nãop Pegou")
            transition.to(object, {  time=TIMER, y = _H - 150 })
        end
    end

    function fnMoveMoeda10(object, colision, multiplo)
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 210, 
            onComplete = function(object)
                fnMoveMoeda11(object, colision, multiplo)
            end 
        })
    end

    function fnMoveMoeda9(object, colision, multiplo)
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 240, 
            onComplete = function(object)
                fnMoveMoeda10(object, colision, multiplo) 
            end    
        })    
    end

    function fnMoveMoeda8(object, colision, multiplo)
        object.x = object.x - multiplo
        transition.to(object, { 
            time = TIMER, 
            y = _H - 270, 
            onComplete = function(object)
                fnMoveMoeda9(object, colision, multiplo) 
            end
        })    
    end

    function fnMoveMoeda7(object, colision, multiplo)
        object.x = object.x - multiplo
        transition.to(object, { 
            time = TIMER, 
            y = _H - 300, 
            onComplete = function(object) 
                fnMoveMoeda8(object, colision, multiplo)
            end
        })    
    end

    function fnMoveMoeda6(object, colision, multiplo)
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 330, 
            onComplete = function(object) 
                fnMoveMoeda7(object, colision, multiplo) 
            end
        })    
    end

    function fnMoveMoeda5(object, colision, multiplo)
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 360, 
            onComplete = function(object) 
                fnMoveMoeda6(object, colision, multiplo) 
            end
        })    
    end

    function fnMoveMoeda4(object, colision, multiplo)
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 390, 
            onComplete = function (object)
                fnMoveMoeda5(object, colision, multiplo)
            end
        })    
    end

    function fnMoveMoeda3(object, colision, multiplo)
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 420, 
            onComplete = function (object) 
                fnMoveMoeda4(object, colision, multiplo)
            end
        })
    end

    function fnMoveMoeda2(object, colision, multiplo)
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 450, 
            onComplete = function(object) 
                fnMoveMoeda3(object, colision, multiplo) 
            end
        })    
    end

    function fnMoveMoeda1(object, colision, multiplo)
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER,
            y = _H - 480, 
            onComplete = function(object) 
                fnMoveMoeda2(object, colision, multiplo) 
            end
        })    
    end

    function load(object, colision, multiplo)
        object.x = object.x - multiplo
        transition.to(object, { 
            time=TIMER, 
            y = _H - 510,
            onComplete = function(object) 
                fnMoveMoeda1(object, colision, multiplo) 
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

    function addTimeCreateMoeda:timer( event )

        local sorteio = math.random(3)
        local sorteio2 = math.random(3)

        local tipoMoeda = _MOEDA_TIPO_NORMAL
        if (sorteio2 == 2) then
            tipoMoeda =_MOEDA_TIPO_MONOTONE
        elseif (sorteio2 == 3) then
            tipoMoeda =_MOEDA_TIPO_INVALIDA
        end
        
        local position = {}
        local colision = {}

        if (sorteio == 1) then
            local moeda = createMoeda(_MOEDA_LEFT, tipoMoeda)
            load(moeda, LEFT, 7)
            sceneGroup:insert(moeda)
        elseif (sorteio == 2) then
            local moeda = createMoeda(_MOEDA_CENTER, tipoMoeda)
            load(moeda, CENTER, 4)
            sceneGroup:insert(moeda)
        else
            local moeda = createMoeda(_MOEDA_RIGHT, tipoMoeda)
            load(moeda, RIGHT, 0)
            sceneGroup:insert(moeda)
        end
    end

    function setData()
        composer.setVariable( "timer", countPoints )
        composer.setVariable( "quantEstrelaNormal", countEstrelaPoints )
        composer.setVariable( "quantEstrela", countEstrelaPoints2 )
    end

    timerPontuacao = timer.performWithDelay( 1000, addTimePontuacao, 0 )
    timeCreateMoeda = timer.performWithDelay( 3000, addTimeCreateMoeda, 0 )

    Runtime:addEventListener("touch", swipe)
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