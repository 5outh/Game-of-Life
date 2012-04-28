local iOHandler = {}

function iOHandler.populateNodes()
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

function iOHandler.keyBindings(key)
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
		iOHandler.startPause()
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

function iOHandler.startPause()
		if(rainbowMode) then
		gameStarted = false
		love.audio.pause(crush)
		musicOn = false
		rainbowMode = false
	else
		gameStarted = not gameStarted
	end
end


return iOHandler