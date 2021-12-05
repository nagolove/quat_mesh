local g = love.graphics

local vf = {
    {"VertexPosition", "float", 1},
    {"VertexColor", "byte", 4},
}

local start_mesh_id = g.newMesh(vf, n * 6, "points")
for i = 1, n * 6 do
    local x, y, z = rnd:random() * 2 - 1, rnd:random() * 2 - 1, rnd:random() * 2 - 1
    local l = math.sqrt(x * x + y * y + z * z)
    if l == 0 then
        l, x, y, z = 1, 1, 0, 0
    end
    local d = 1 + rnd:random() * 100
    x, y, z = d * x / l, d * y / l, d * z / l
    z = z
    start_mesh_3d:setVertex(i, x, y, z, 1, 1, 1, 1)
end

function love.load()
end

local orient = love.math.newTransform()

local function set_orientation(x, y, z, w)
    local l = math.sqrt(x * x + y * y + z * z)
    -- Верно?
    assert(l ~= 0)
    x, y, z = x / l, y / l, z / l
    local w, c = math.sin(w), math.cos(w)
    x, y, z = x * c, y * c, z * c
    orient:setMatrix(
        1 - 2 * y * y - 2 * z * z, 2 * x * y + 2 * w * z, 2 * x * z - 2 * w * y, 0,
        2 * x * y - 2 * w * z, 1 - 2 * x * x - 2 * z * z, 2 * y * z + 2 * w * x, 0,
        2 * x * z + 2 * w * y, 2 * y * z - 2 * w * x, 1 - 2 * x * x - 2 * y * y, 0,
        0, 0, 0, 1
    )
    g.applyTransform(origin)
end

function love.draw()
    local ox, oy = love.timer.getTime() * 12 % w, love.timer.getTime() * 15 % h
    ox, oy = love.mouse.getPosition()
    g.translate(w / 2, h / 2)
end
