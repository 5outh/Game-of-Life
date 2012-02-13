function love.load()
	--audioSource = love.audio.newSource("Spitfire.mp3", "stream")
	--love.audio.play(audioSource)
	xSize = love.graphics.getWidth()
	ySize = love.graphics.getHeight()
	xPosition, yPosition = (love.graphics.getWidth() + xSize)/2 , (love.graphics.getHeight() + ySize)/2
	nodeSize = 10
	
	xNodes = xSize/nodeSize
	yNodes = ySize/nodeSize
	
	array = {0,0}
	for i = 0, xNodes do
		array[i] = {}
		for j = 0, yNodes do
			array[i][j] = 0
		end
	end
	
	gameStarted = false
	love.graphics.setBackgroundColor(45, 3, 58)
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
end

function love.draw(dt)
	love.graphics.setColor(211, 231, 255)
	
	step = nodeSize
	while(step <= xSize) do
		if(step <= ySize) then
			love.graphics.line(nodeSize, step, xSize, step)
		end
		love.graphics.line(step, nodeSize, step, ySize)
		step = step +nodeSize
	end

	for i = 1, xNodes-1 do
		for j = 1, yNodes-1 do
			if array[i][j] == 1 then
				love.graphics.setColor(255,255,255)
				love.graphics.rectangle('fill', i*nodeSize, j*nodeSize, nodeSize, nodeSize)
			end
		end
	end
end

function click_update(x, y)
	 xCoordinate = (x - (x % nodeSize)) /nodeSize 
	 yCoordinate = (y - (y % nodeSize)) /nodeSize
	 if xCoordinate < #array and yCoordinate < #array[1]then
		array[xCoordinate][yCoordinate] = math.abs(array[xCoordinate][yCoordinate]-1)
	 end
end

function love.mousepressed(x, y, button)
   if button == "l" then
	    click_update(x, y)
   end
end

function love.keypressed(key)
	if key == "1" then
		gameStarted = true
	end
	if key == "2" then
		gameStarted = false
	end
end