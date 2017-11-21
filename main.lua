function love.load()
    bird = {}
    bird.x = 65
    bird.y = 200
    bird.width = 30
    bird.height = 25
    bird.ySpeed = 0
    g = 500
    jumpForce = 300

    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getHeight()

    pipe = {}
    pipe.spaceHeight = 100
    pipe.spaceMin = 64
    pipe.speed = 120
    pipe.width = 64

    resetPipe()
end

function love.update(dt)
    bird.ySpeed = bird.ySpeed + (g * dt)
    bird.y = bird.y + (bird.ySpeed * dt)

    pipe.x = pipe.x - (pipe.speed * dt)

    if pipe.x + pipe.width < 0 then
        resetPipe()
    end

    pipeCollisionCheck()
end

function love.draw()
    love.graphics.setColor(31, 97, 127)
    love.graphics.rectangle('fill', 0, 0, windowWidth, windowHeight)

    love.graphics.setColor(255, 215, 63)
    love.graphics.rectangle('fill', bird.x, bird.y, bird.width, bird.height)

    love.graphics.setColor(94, 201, 72)
    love.graphics.rectangle('fill', pipe.x, 0, pipe.width, pipe.spaceY)
    love.graphics.rectangle('fill', pipe.x, pipe.spaceY + pipe.spaceHeight, pipe.width, windowHeight - pipe.spaceY - pipe.spaceHeight)
end

function love.keypressed(key)
    if (bird.y > 0) then
        bird.ySpeed = -jumpForce
    end
end

function resetPipe()
    pipe.spaceY = love.math.random(pipe.spaceMin, windowHeight - pipe.spaceHeight - pipe.spaceMin)
    pipe.x = windowWidth
end

function pipeCollisionCheck()
    if bird.x < (pipe.x + pipe.width) and
        (bird.x + bird.width) > pipe.x and
        (bird.y < pipe.spaceY or (bird.y + bird.height) > (pipe.spaceY + pipe.spaceHeight))
    then
        love.load()
    end
end