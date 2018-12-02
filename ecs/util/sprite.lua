local M = {}


local function rotate(x0, y0, x1, y1, a)
	a = a * math.pi/180
	local x = (x1-x0)*math.cos(a) - (y1-y0)*math.sin(a) + x0
	local y = (x1-x0)*math.sin(a) + (y1-y0)*math.cos(a) + y0
	return x, y
end


function M.e_calc_aabb(e)
	local aabb = e.aabb
	local w = e.w * e.sx
	local h = e.h * e.sy

	aabb[1].x, aabb[1].y = e.x-e.ax*w, e.y+(1-e.ay)*h
	aabb[2].x, aabb[2].y = e.x-e.ax*w, e.y-e.ay*h
	aabb[3].x, aabb[3].y = e.x+(1-e.ax)*w, e.y-e.ay*h
	aabb[4].x, aabb[4].y = e.x+(1-e.ax)*w, e.y+(1-e.ay)*h

	aabb[1].x, aabb[1].y = rotate(e.x, e.y, aabb[1].x, aabb[1].y, e.angle)
	aabb[2].x, aabb[2].y = rotate(e.x, e.y, aabb[2].x, aabb[2].y, e.angle)
	aabb[3].x, aabb[3].y = rotate(e.x, e.y, aabb[3].x, aabb[3].y, e.angle)
	aabb[4].x, aabb[4].y = rotate(e.x, e.y, aabb[4].x, aabb[4].y, e.angle)
end

function M.e_in_aabb(e, x, y)
	local aabb = e.aabb
	if x < aabb[1].x or x > aabb[4].x then return false end
	if y > aabb[1].y or y < aabb[2].y then return false end
	return true
end


return M