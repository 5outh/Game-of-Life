local arrayHandler = {}
function arrayHandler.clearArray()
	array = {0,0}
	for i = 0, xNodes do
		array[i] = {}
		for j = 0, yNodes do
			array[i][j] = 0
		end
	end
end

function arrayHandler.changeSize(x)
	prevXNodes = xNodes
	prevYNodes = yNodes
	
	nodeSize = nodeSize + x
	xNodes = xSize / nodeSize
	yNodes = ySize / nodeSize
	
	arrayHandler.resize(prevXNodes, prevYNodes, xNodes, yNodes)
end

function arrayHandler.resize(xNodes, yNodes, newXNodes, newYNodes)
	-- handles graceful changes in grid size
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

function arrayHandler.get_next(cur_array)
	newArray = {}
	for i = 0, xNodes do
		newArray[i] = {}
		for j = 0, yNodes do
			newArray[i][j] = 0
		end
	end
	
	for i = 1, xNodes do
		for j = 1, yNodes do
			neighbors = 0
			
			left = i == 1
			right = i == xNodes
			bottom = j == yNodes
			top = j == 1
			
			if left then
				neighbors = neighbors + array[xNodes][j]
			else
				neighbors = neighbors + array[i-1][j]
			end
			
			if right then
				neighbors = neighbors + array[1][j]
			else
				neighbors = neighbors + array[i+1][j]
			end
			
			if top then
				neighbors = neighbors + array[i][yNodes]
			else
				neighbors = neighbors + array[i][j-1]
			end
			
			if bottom then
				neighbors = neighbors + array[i][1]
			else
				neighbors = neighbors + array[i][j+1]
			end
			
			if left or bottom then
				if left and bottom then
					neighbors = neighbors + array[xNodes][1]
				elseif left then
					neighbors = neighbors + array[xNodes][j+1]
				elseif bottom then
					neighbors = neighbors + array[i-1][1]
				end
			else
				neighbors = neighbors + array[i-1][j+1]
			end
			
			if right or bottom then
				if right and bottom then
					neighbors = neighbors + array[1][1]
				elseif right then
					neighbors = neighbors + array[1][j+1]
				elseif bottom then
					neighbors = neighbors + array[i+1][1]
				end
			else
				neighbors = neighbors + array[i+1][j+1]
			end
			
			if top or left then
				if top and left then
					neighbors = neighbors + array[xNodes][yNodes]
				elseif top then
					neighbors = neighbors + array[i-1][yNodes]
				elseif left then
					neighbors = neighbors + array[xNodes][j-1]
				end
			else
				neighbors = neighbors + array[i-1][j-1]
			end
			
			if top or right then
				if top and right then
					neighbors = neighbors + array[1][yNodes]
				elseif top then
					neighbors = neighbors + array[i+1][yNodes]
				elseif right then
					neighbors = neighbors + array[1][j-1]
				end
			else
				neighbors = neighbors + array[i+1][j-1]
			end
			
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

return arrayHandler