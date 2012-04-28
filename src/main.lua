local arrayHandler 
local drawing
local iOHandler
local presets

function love.load()
	arrayHandler = require('lib/arrayHandler')
	drawing = require('lib/drawing')
	iOHandler = require('lib/IOHandler')
	presets = require('lib/presets')
	crush = love.audio.newSource("assets/crush.mp3", "stream")
	
	largeFont = love.graphics.newFont(36)
	mediumFont = love.graphics.newFont(16)
	
	nodeSize = 12
	xSize = 864
	ySize = 576
	xNodes = xSize /nodeSize
	yNodes = ySize / nodeSize
	
	gameStarted = false
	rainbowMode = false
	musicOn = false
	
	arrayHandler.clearArray()
	
	love.graphics.setMode(1000, 800, false, true, 0)
	xPosition = (love.graphics.getWidth() - xSize- nodeSize) / 2
	yPosition = (love.graphics.getHeight() - ySize- nodeSize) * 2/3

	startButton = {
		x = love.graphics.getWidth() - 200,
		y = 20,
		width = 160,
		height = 30
	}
	
	love.graphics.setBackgroundColor(34, 32, 40)
end


function love.update(dt)
	if gameStarted then
		array = arrayHandler.get_next(array)
	end
	iOHandler.populateNodes()
end

function love.draw(dt)
	drawing.drawBase()
	drawing.drawGrid()
	drawing.drawArray()
	
	if rainbowMode then
		drawing.drawRainbowMessage()
	end
	
	drawing.drawButton()
	
end

function love.mousepressed(x, y, button)
   if button == "l" then
		if(onButton(x, y, startButton)) then
			iOHandler.startPause()
		end
    end
end

function onButton(x, y, button)
	return x >= button.x and x < button.x + button.width and y >= button.y and y <= button.y + button.height
end

function love.keypressed(key)
	presets.keyPresses(key)
	iOHandler.keyBindings(key)
end
