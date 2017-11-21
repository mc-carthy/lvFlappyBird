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

    resetPipe(1)
    resetPipe(2)

    pipe.x1 = 300
    pipe.x2 = 500
end

function love.update(dt)
    bird.ySpeed = bird.ySpeed + (g * dt)
    bird.y = bird.y + (bird.ySpeed * dt)

    pipe.x1 = pipe.x1 - (pipe.speed * dt)
    pipe.x2 = pipe.x2 - (pipe.speed * dt)

    if pipe.x1 + pipe.width < 0 then
        resetPipe(1)
    end
    if pipe.x2 + pipe.width < 0 then
        resetPipe(2)
    end

    pipeCollisionCheck(pipe.x1, pipe.spaceY1)
    pipeCollisionCheck(pipe.x2, pipe.spaceY2)
end

function love.draw()
    love.graphics.setColor(31, 97, 127)
    love.graphics.rectangle('fill', 0, 0, windowWidth, windowHeight)

    love.graphics.setColor(255, 215, 63)
    love.graphics.rectangle('fill', bird.x, bird.y, bird.width, bird.height)

    drawPipe(pipe.x1, pipe.spaceY1)
    drawPipe(pipe.x2, pipe.spaceY2)
end

function love.keypressed(key)
    if (bird.y > 0) then
        bird.ySpeed = -jumpForce
    end
end

function resetPipe(pipeNum)
    if pipeNum == 1 then
        pipe.spaceY1 = love.math.random(pipe.spaceMin, windowHeight - pipe.spaceHeight - pipe.spaceMin)
        pipe.x1 = windowWidth
    else
        pipe.spaceY2 = love.math.random(pipe.spaceMin, windowHeight - pipe.spaceHeight - pipe.spaceMin)
        pipe.x2 = windowWidth
    end
end

function pipeCollisionCheck(pipeX, pipeSpaceY)
    if bird.x < (pipeX + pipe.width) and
        (bird.x + bird.width) > pipeX and
        (bird.y < pipeSpaceY or (bird.y + bird.height) > (pipeSpaceY + pipe.spaceHeight))
    then
        love.load()
    end
end

function drawPipe(pipeX, pipeSpaceY)
    love.graphics.setColor(94, 201, 72)
    love.graphics.rectangle('fill', pipeX, 0, pipe.width, pipeSpaceY)
    love.graphics.rectangle('fill', pipeX, pipeSpaceY + pipe.spaceHeight, pipe.width, windowHeight - pipeSpaceY - pipe.spaceHeight)
end