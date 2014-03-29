<<<<<<< HEAD
<<<<<<< HEAD
require "enemy"

function love.turris.newGame()
  local o = {}
  o.map = {}
  o.ground = {}
  o.tower = {}
  o.enemies = {}
  o.enemyCount = 7
  for i=1, o.enemyCount do
    o.enemies[i]= love.turris.newEnemy()
    o.enemies[i].x = i*5
    o.enemies[i].y = 0
  end

  o.update = function()

  end



  o.drawMap = function()
    if o.map and o.map.width and o.map.height then
      for i = 1, o.map.width do
        for k = 1, o.map.height do
          G.setColor(255, 255, 255)
          G.draw(o.ground[1], i * 32, k * 24)
          if o.map.map[i][k] > 0 then
            G.setColor(255, 255, 255)
            G.draw(o.tower[o.map.map[i][k]].img, i * 32, k * 24 - 8)
          end
        end
      end
    end
  end
  o.newGround = function(img)
    o.ground[#o.ground + 1] = G.newImage(img)
    return o.ground[#o.ground]
  end
  o.newTower = function(img)
    o.tower[#o.tower + 1] = love.turris.newTower(img)
    return o.tower[#o.tower]
  end
  o.getTower = function(n)
    return o.tower[n]
  end
  o.setMap = function(map)
    o.map = map
  end
  o.map = love.turris.newMap(20, 20)

  o.map.setState(7, 13, 1)
  o.map.setState(4, 3, 1)
  o.newGround("gfx/ground01.png")
  o.newTower("gfx/tower01.png")
  return o
=======
=======
>>>>>>> a69e21b6167c96234265f2610b276da1d0638a64
function love.turris.newGame()
	o = {}
	o.map = {}
	o.ground = {}
	o.tower = {}
	o.init = function()
		o.newGround("gfx/ground01.png")
		o.newTower("gfx/tower00_diffuse.png")
		turMap.setState(4, 3, 1)
		turMap.setState(7, 13, 1)
		o.setMap(turMap.getMap())
	end
	o.update = function()

	end
	o.drawMap = function()
		if o.map and o.map.width and o.map.height then
			for i = 1, o.map.width do
				for k = 1, o.map.height do
					G.setColor(255, 255, 255)
					G.draw(o.ground[1], i * 32, k * 24)
				end
			end
			for i = 1, o.map.width do
				for k = 1, o.map.height do
					if o.map.map[i][k] > 0 then
						local img = o.tower[o.map.map[i][k]].img
						G.setColor(255, 255, 255)
						G.draw(img, i * 32, k * 24 - 8, 0, 1.0 / img:getWidth() * 80, 1.0 / img:getHeight() * 64)
					end
				end
			end
		end
	end
	o.newGround = function(img)
		o.ground[#o.ground + 1] = G.newImage(img)
		return o.ground[#o.ground]
	end
	o.newTower = function(img)
		o.tower[#o.tower + 1] = love.turris.newTower(img)
		return o.tower[#o.tower]
	end
	o.getTower = function(n)
		return o.tower[n]
	end
	o.setMap = function(map)
		o.map = map
	end

	return o
<<<<<<< HEAD
>>>>>>> a69e21b6167c96234265f2610b276da1d0638a64
=======
>>>>>>> a69e21b6167c96234265f2610b276da1d0638a64
end