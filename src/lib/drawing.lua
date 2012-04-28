local drawing = {}

function drawing.drawBase()
	love.graphics.setColor(197, 199, 182) -- top banner and grid  (grey)
	love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight()/12)
end

function drawing.drawGrid()
	step = nodeSize
	while(step <= xSize) do
		if(step <= ySize) then
			love.graphics.line(nodeSize+xPosition, step+yPosition, xSize+xPosition, step+yPosition)
		end
		love.graphics.line(step+xPosition, nodeSize+yPosition, step+xPosition, ySize+yPosition)
		step = step + nodeSize
	end
end

function drawing.drawArray()
	love.graphics.setColor(255,248,211) -- nodes (off-white)
	for i = 1, xNodes-1 do
		for j = 1, yNodes-1 do
			if array[i][j] == 1 then
				if rainbowMode then
					love.graphics.setColor(math.random(255), math.random(255), math.random(255))
				end
				love.graphics.rectangle('fill', i*nodeSize + xPosition, j*nodeSize + yPosition, nodeSize, nodeSize)
			end
		end
	end
end

function drawing.drawRainbowMessage()
	love.graphics.setFont(largeFont)
	love.graphics.print("RAINBOWMODE", 300, 80, 0)
	love.graphics.setFont(mediumFont)
end

function drawing.drawButton()
	love.graphics.setColor(47, 56, 55) -- top banner underline, start button
	love.graphics.rectangle('fill', startButton.x, startButton.y, startButton.width, startButton.height)
	love.graphics.rectangle('fill', 0, love.graphics.getHeight()/12,  love.graphics.getWidth(), love.graphics.getHeight()/192)

	love.graphics.setColor(255, 248, 211) -- off-white
	love.graphics.setFont(mediumFont)
	if(gameStarted) then
		love.graphics.print("Pause Game", startButton.x + 35, startButton.y - 5 + startButton.height /3, 0)
	else
		love.graphics.print("Start Game", startButton.x + 35, startButton.y - 5 + startButton.height /3, 0)
	end
end

return drawing