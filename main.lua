function love.load()
	ggg = love.filesystem.load("Presets/GosperGliderGun.lua")
	crush = love.audio.newSource("crush.mp3", "stream")
	love.graphics.setMode(1000, 800, false, true, 8)
	largeFont = love.graphics.newFont(24)
	smallFont = love.graphics.newFont(12)
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
	
	smallSquare ={
		width = 24,
		height = 24,
		x = 20,
		y = 32
	}
	
	xPosition = (love.graphics.getWidth() - xSize- nodeSize) / 2
	yPosition = (love.graphics.getHeight() - ySize- nodeSize) * 2/3

	array = {0,0}
	for i = 0, xNodes do
		array[i] = {}
		for j = 0, yNodes do
			array[i][j] = 0
		end
	end
	gameStarted = false
	rainbowMode = false
	musicOn = false
	
	love.graphics.setBackgroundColor(34, 32, 40)
end

function get_next(cur_array)
	vals = ''
	newArray = {}
	for i = 0, xNodes do
		newArray[i] = {}
		for j = 0, yNodes do
			newArray[i][j] = 0
		end
	end
	for i = 1, xNodes-1 do
		for j = 1, yNodes-1 do
			neighbors = 0
			
			neighbors = neighbors + array[i-1][j]
			neighbors = neighbors + array[i-1][j-1]
			neighbors = neighbors + array[i-1][j+1]
			neighbors = neighbors + array[i+1][j]
			neighbors = neighbors + array[i+1][j+1]
			neighbors = neighbors + array[i+1][j-1]
			neighbors = neighbors + array[i][j-1]
			neighbors = neighbors + array[i][j+1]
			
			-- handle node generation, update array
			if array[i][j] == 1 then
				if neighbors == 2 or neighbors == 3 then
					newArray[i][j] = 1
				else
					newArray[i][j] = 0
				end
			elseif array[i][j] == 0 then
				if neighbors == 3 then
					newArray[i][j] = 1
				else
					newArray[i][j] = 0
				end
			end
		end
	end
	return newArray
end

function love.update(dt)
	if gameStarted then
		array = get_next(array)
	end
	if love.mouse.isDown("r", "l") then
		 x = love.mouse.getX() - xPosition
		 y = love.mouse.getY() - yPosition
		 if x > 0 and y > 0 then
			xCoordinate = (x - (x % nodeSize)) /nodeSize 
			yCoordinate = (y - (y % nodeSize)) /nodeSize
			if xCoordinate < #array and yCoordinate < #array[1]then
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
	
	love.graphics.setColor(197, 199, 182) -- top banner and grid  (grey)
	love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight()/12)
	
	step = nodeSize
	while(step <= xSize) do
		if(step <= ySize) then
			love.graphics.line(nodeSize+xPosition, step+yPosition, xSize+xPosition, step+yPosition)
		end
		love.graphics.line(step+xPosition, nodeSize+yPosition, step+xPosition, ySize+yPosition)
		step = step +nodeSize
	end
	
	love.graphics.setColor(255,248,211) -- nodes (off-white)
	for i = 1, xNodes-1 do
		for j = 1, yNodes-1 do
			if array[i][j] == 1 then
				if rainbowMode then
					love.graphics.setColor(math.random(255), math.random(255), math.random(255))
					love.graphics.print("FUCKIN RAINBOWMODE", 360, 15, 0, 2)
				end
				love.graphics.rectangle('fill', i*nodeSize + xPosition, j*nodeSize + yPosition, nodeSize, nodeSize)
			end
		end
	end
	
	love.graphics.setColor(47, 56, 55) -- top banner underline, start button
	love.graphics.rectangle('fill', startButton.x, startButton.y, startButton.width, startButton.height)
	love.graphics.rectangle('fill', 0, love.graphics.getHeight()/12,  love.graphics.getWidth(), love.graphics.getHeight()/192)
	
	if(not rainbowMode) then
		love.graphics.setColor(255, 248, 211) -- off-white
		love.graphics.setFont(mediumFont)
		if(gameStarted) then
			love.graphics.print("Pause Game", startButton.x + 35, startButton.y - 5 + startButton.height /3, 0)
		else
			love.graphics.print("Start Game", startButton.x + 35, startButton.y - 5 + startButton.height /3, 0)
		end
	end
	
	--love.graphics.print(love.mouse.getX()..','..love.mouse.getY(), love.mouse.getX(), love.mouse.getY())
	
end

function love.mousepressed(x, y, button)
   if button == "l" then
		if(onButton(x, y, startButton)) then
			if(rainbowMode) then
				gameStarted = false
				love.audio.pause(crush)
				musicOn = false
				rainbowMode = false
			else
				gameStarted = not gameStarted
			end
		end
    end
end

function onButton(x, y, button)
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
	if key == "up" then
		if nodeSize < 24 then
			changeSize(6)
		end
	end
	if key == "down" then
		if nodeSize > 6 then
			changeSize(-6)
		end
	end
end

function clearArray()
	array = {0,0}
	for i = 0, xNodes do
		array[i] = {}
		for j = 0, yNodes do
			array[i][j] = 0
		end
	end
end

function changeSize(x)
	prevXNodes = xNodes
	prevYNodes = yNodes
	
	nodeSize = nodeSize + x
	xNodes = xSize / nodeSize
	yNodes = ySize / nodeSize
	
	resize(prevXNodes, prevYNodes, xNodes, yNodes)
end


function resize(xNodes, yNodes, newXNodes, newYNodes)
	if xNodes <= newXNodes then
		newArray = {0,0}
		for i = 0, newXNodes do
			newArray[i] = {}
			for j = 0, newYNodes do
				newArray[i][j] = 0
			end
		end
		
		for i = 0, xNodes do
			for j = 0, yNodes do
				newArray[i][j] = array[i][j]
			end
		end
	else
		newArray = {0,0}
		for i = 0, xNodes do
			newArray[i] = {}
			for j = 0, yNodes do
				newArray[i][j] = 0
			end
		end
		
		for i = 0, newXNodes do
			for j = 0, newYNodes do
				newArray[i][j] = array[i][j]
			end
		end
	end
		
	array = newArray
end
