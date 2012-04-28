local presets = {}

function presets.keyPresses(key)
	if(key == "1") then
		presets.gosperGliderGun()
	end
end

function presets.gosperGliderGun()
	array = {0,0}
	for i = 0, xNodes do
		array[i] = {}
		for j = 0, yNodes do
			array[i][j] = 0
		end
	end

	array[2][6] = 1
	array[2][7] = 1

	array[3][6] = 1
	array[3][7] = 1

	array[12][6] = 1
	array[12][7] = 1
	array[12][8] = 1

	array[13][5] = 1
	array[13][9] = 1

	array[14][4] = 1
	array[14][10] = 1

	array[15][4] = 1
	array[15][10] = 1

	array[16][7] = 1

	array[17][5] = 1
	array[17][9] = 1

	array[18][6] = 1
	array[18][7] = 1
	array[18][8] = 1

	array[19][7] = 1

	array[22][4] = 1
	array[22][5] = 1
	array[22][6] = 1

	array[23][4] = 1
	array[23][5] = 1
	array[23][6] = 1

	array[24][3] = 1
	array[24][7] = 1

	array[26][2] = 1
	array[26][3] = 1
	array[26][7] = 1
	array[26][8] = 1

	array[36][4] = 1
	array[36][5] = 1
	array[37][4] = 1
	array[37][5] = 1


	return array
end

return presets