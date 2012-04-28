local arrayHandler 
local drawing

function love.load()
	arrayHandler = require('arrayHandler')
	drawing = require('drawing')
	ggg = love.filesystem.load("presets/GosperGliderGun.lua")
	crush = love.audio.newSource("crush.mp3", "stream")
	love.graphics.setMode(1000, 800, false, true, 0)
	largeFont = love.graphics.newFont(36)
	mediumFont = love.graphics.newFont(16)
	
	nodeSize = 12
	xSize = 864
	ySize = 576
	xNodes = xSize /nodeSize
	yNodes = ySize / nodeSize
	
	startButton = {
		x = love.graphics.getWidth() - 200,
		y = 20,
		width = 160,
		height = 30
	}
	
	xPosition = (love.graphics.getWidth() - xSize- nodeSize) / 2
	yPosition = (love.graphics.getHeight() - ySize- nodeSize) * 2/3

	arrayHandler.clearArray()
	
	gameStarted = false
	rainbowMode = false
	musicOn = false
	
	love.graphics.setBackgroundColor(34, 32, 40)
end

function love.update(dt)
	if gameStarted then
		array = arrayHandler.get_next(array)
	end
	-- node population
	if love.mouse.isDown("r", "l") then
		 x = love.mouse.getX() - xPosition
		 y = love.mouse.getY() - yPosition
		 if x > 0 and y > 0 then
			xCoordinate = (x - (x % nodeSize)) /nodeSize 
			yCoordinate = (y - (y % nodeSize)) /nodeSize
			if xCoordinate < #array and yCoordinate < #array[1] then
				if love.mouse.isDown("r") then
					array[xCoordinate][yCoordinate] = 0
				elseif love.mouse.isDown("l") then
					array[xCoordinate][yCoordinate] = 1
				end
			end	
		end
	end
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
			startPause()
		end
    end
end

function startPause()
	if(rainbowMode) then
		gameStarted = false
		love.audio.pause(crush)
		musicOn = false
		rainbowMode = false
	else
		gameStarted = not gameStarted
	end
end

function onButton(x, y, button)
	-- button hit test
	return x >= button.x and x < button.x + button.width and y >= button.y and y <= button.y + button.height
end

function love.keypressed(key)
	if key == "r" then
		rainbowMode = not rainbowMode
		gameStarted = rainbowMode
		musicOn = not musicOn
		if(musicOn) then
			love.audio.play(crush)
			love.audio.resume(crush)
		else
			love.audio.pause(crush)
		end
	end
	if key == "c" then
		arrayHandler.clearArray()
	end
	if key == "p" then
		startPause()
	end
	if key == "up" then
		if nodeSize < 24 then
			arrayHandler.changeSize(6)
		end
	end
	if key == "down" then
		if nodeSize > 6 then
			arrayHandler.changeSize(-6)
		end
	end
end
