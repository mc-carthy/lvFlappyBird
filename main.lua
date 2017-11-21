function love.load()
    bird = {}
    bird.y = 200
    bird.ySpeed = 0
    g = 500
    jumpForce = 300

    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getHeight()

    pipeSpaceHeight = 100
    pipeSpaceY = love.math.random(0, windowHeight - pipeSpaceHeight)
end

function love.update(dt)
    bird.ySpeed = bird.ySpeed + (g * dt)
    -- bird.y = bird.y + (bird.ySpeed * dt)
end

function love.draw()
    love.graphics.setColor(31, 97, 127)
    love.graphics.rectangle('fill', 0, 0, windowWidth, windowHeight)

    love.graphics.setColor(255, 215, 63)
    love.graphics.rectangle('fill', 65, bird.y, 30, 25)

    local pipeWidth = 64

    love.graphics.setColor(94, 201, 72)
    love.graphics.rectangle('fill', windowWidth, 0, -pipeWidth, pipeSpaceY)
    love.graphics.rectangle('fill', windowWidth, pipeSpaceY + pipeSpaceHeight, -pipeWidth, windowHeight - pipeSpaceY - pipeSpaceHeight)
end

function love.keypressed(key)
    -- if (bird.y > 0) then
    --     bird.ySpeed = -jumpForce
    -- end

    love.load()
end