-- A Program to play conways game of life
function love.load()
	love.graphics.setBackgroundColor(1, 1, 1)

	CellSize = 10

	GridXCount = 80
	GridYCount = 60

	Grid = {}
	for y = 1, GridYCount do
		Grid[y] = {}
		for x = 1, GridXCount do
			Grid[y][x] = false
		end
	end

	love.keyboard.setKeyRepeat(true)
end

function love.update()
	SelectedX = math.min(math.floor(love.mouse.getX() / CellSize) + 1, GridXCount)
	SelectedY = math.min(math.floor(love.mouse.getY() / CellSize) + 1, GridYCount)

	if love.mouse.isDown(1) then
		Grid[SelectedY][SelectedX] = true
	elseif love.mouse.isDown(2) then
		Grid[SelectedY][SelectedX] = false
	end
end

function love.draw()
	for y = 1, GridYCount do
		for x = 1, GridXCount do
			local cellDrawSize = CellSize - 1

			if x == SelectedX and y == SelectedY then
				love.graphics.setColor(0, 1, 1)
			elseif Grid[y][x] then
				love.graphics.setColor(1, 0, 1)
			else
				love.graphics.setColor(.86, .86, .86)
			end

			love.graphics.rectangle(
				'fill',
				(x - 1) * CellSize,
				(y - 1) * CellSize,
				cellDrawSize,
				cellDrawSize
			)
		end
	end

	love.graphics.setColor(0, 0, 0)
	love.graphics.print('selected x: '..SelectedX..', selected y: '..SelectedY)
end

function love.keypressed()
	local nextGrid = {}

	for y = 1, GridYCount do
		nextGrid[y] = {}
		for x = 1, GridXCount do
			local neighbourCount = 0

			for dy = -1, 1 do
				for dx = -1, 1 do
					if not (dy == 0 and dx == 0) and Grid [y + dy] and Grid[y + dy][x + dx] then
						neighbourCount = neighbourCount + 1
					end
				end
			end

			nextGrid[y][x] = neighbourCount == 3 or (Grid[y][x] and neighbourCount == 2)
		end
	end

	Grid = nextGrid
end

