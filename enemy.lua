require "ai/ai"

function love.turris.newEnemy(img, map, baseX, baseY)
	local o = {}
	o.generateWaypoints = function(map, startX, startY, goalX, goalY)
		local mapXmax = map.width
		local mapYmax = map.height
		print ("x: "..startX)
		print ("y: "..startY)
		--goal found
		if (startX==goalX and startY==goalY)then
			local wp = {{goalX,goalY}}
			return wp
		end
		local visited = {}
		for i = 1, map.width do
			for j = 1, 20 do
				visited[j]=false
				visited[i]=visited[j]
			end
		end

		local wp = {{startX,startY},{goalX,goalY}}
		return wp
	end
	o.img = img
	o.x = {}
	o.y = {}
	o.waypoints = o.generateWaypoints(map,0,baseY,baseX,baseY)

	o.currentWaypoint = 2
	o.health = 100.0

	-- TODO this depends on the type and not on the particular enemy
	o.maxHealth = 100.0
	o.speed = 2
	-- type end


	o.updateVelocity = function(dirX,dirY)
		o.xVel = dirX*o.speed
		o.yVel = dirY*o.speed
	end

	o.updateVelocity(1,0) --TODO this should be determined from the current position to the next waypoint
	o.getOrientation = function()
		local x,y = love.turris.normalize(o.xVel, o.yVel)
		return x,y
	end

	return o
end
function love.turris.normalize(x,y)
	local m = math.max(math.abs(x),math.abs(y))
	return x/m, y/m
end
function love.turris.updateEnemies(o,dt)
	for i = 1, o.enemyCount do
		local e = o.enemies[i]
		e.x = e.x+e.xVel*dt
		e.y = e.y+e.yVel*dt

		local x = e.x
		local y = e.y

		-- check if waypoint reached
		local wp = e.waypoints[e.currentWaypoint]
		if math.abs(wp[1]-x)<0.1 and math.abs(wp[2] -y)<0.1 then
			-- waypoint reached
			local nextWpIndex = e.currentWaypoint +1
			e.currentWaypoint = nextWpIndex
			local wpNext = e.waypoints[nextWpIndex]
			local dirX,dirY = love.turris.normalize( wpNext[1]-wp[1], wpNext[2]-wp[2])
			e.updateVelocity(dirX,dirY)
		end

		-- write back the changes
		o.enemies[i]= e
		-- check for and handle game over
		if math.abs(o.baseX - x) <1 and math.abs(y - o.baseY) < 1 then
			-- Game Over!!! (for now)
			-- TODO: destroy ship (explosion)
			-- TODO: destroy base (explosion!)
			-- TODO: after explosions have finished -> transition to game over state
			love.sounds.playSound("sounds/main_base_explosion.wav")
			love.setgamestate(4)
			gameOverEffect = 0
		end
	end
end