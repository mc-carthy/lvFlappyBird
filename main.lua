function love.load()
    bird = {}
    bird.image = love.graphics.newImage('bird.png')
    bird.imageX, bird.imageY = bird.image:getDimensions()
    bird.x = 65
    bird.y = 200
    bird.width = 30
    bird.height = 25
    bird.ySpeed = 0
    g = 500
    jumpForce = 300

    score = 0
    nextPipe = 1

    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getHeight()

    pipe = {}
    pipe.spaceHeight = 100
    pipe.spaceMin = 64
    pipe.speed = 120
    pipe.width = 64

    pipe.spaceY1 = newPipeSpaceY()
    pipe.spaceY2 = newPipeSpaceY()

    pipe.x1 = windowWidth
    pipe.x2 = windowWidth * 1.5
end

function love.update(dt)
    bird.ySpeed = bird.ySpeed + (g * dt)
    bird.y = bird.y + (bird.ySpeed * dt)

    local function movePipe(pipeX, pipeSpaceY)
        pipeX = pipeX - (pipe.speed * dt)
        if (pipeX + pipe.width) < 0 then
            pipeX = windowWidth
            pipeSpaceY = newPipeSpaceY()
        end

        return pipeX, pipeSpaceY
    end

    pipe.x1, pipe.spaceY1 = movePipe(pipe.x1, pipe.spaceY1)
    pipe.x2, pipe.spaceY2 = movePipe(pipe.x2, pipe.spaceY2)

    if pipeCollisionCheck(pipe.x1, pipe.spaceY1) or
        pipeCollisionCheck(pipe.x2, pipe.spaceY2) or
        bird.y > windowHeight then
            love.load()
    end

    pipeScoreCheck()
end

function love.draw()
    love.graphics.setColor(31, 97, 127)
    love.graphics.rectangle('fill', 0, 0, windowWidth, windowHeight)

    love.graphics.setColor(255, 215, 63)
    -- love.graphics.rectangle('fill', bird.x, bird.y, bird.width, bird.height)
    love.graphics.draw(bird.image, bird.x + bird.width / 2, bird.y + bird.height / 2, math.atan(bird.ySpeed / pipe.speed), bird.width / bird.imageX, bird.height / bird.imageY, bird.imageX / 2, bird.imageY / 2)

    drawPipe(pipe.x1, pipe.spaceY1)
    drawPipe(pipe.x2, pipe.spaceY2)

    love.graphics.setColor(255, 255, 255)
    love.graphics.print(score, 15, 15)
end

function love.keypressed(key)
    if key ~= 'escape' then
        if (bird.y > 0) then
            bird.ySpeed = -jumpForce
        end
    else
        love.event.quit(0)
    end
end

function newPipeSpaceY(pipeNum)
    return love.math.random(pipe.spaceMin, windowHeight - pipe.spaceHeight - pipe.spaceMin)
end

function pipeCollisionCheck(pipeX, pipeSpaceY)
    if bird.x < (pipeX + pipe.width) and
        (bird.x + bird.width) > pipeX and
        (bird.y < pipeSpaceY or (bird.y + bird.height) > (pipeSpaceY + pipe.spaceHeight))
    then
        return true
    end
end

function pipeScoreCheck()
    if nextPipe == 1 and (bird.x > (pipe.x1 + pipe.width)) then
        score = score + 1
        nextPipe = 2
    end

    if nextPipe == 2 and (bird.x > (pipe.x2 + pipe.width)) then
        score = score + 1
        nextPipe = 1
    end
end

function drawPipe(pipeX, pipeSpaceY)
    love.graphics.setColor(94, 201, 72)
    love.graphics.rectangle('fill', pipeX, 0, pipe.width, pipeSpaceY)
    love.graphics.rectangle('fill', pipeX, pipeSpaceY + pipe.spaceHeight, pipe.width, windowHeight - pipeSpaceY - pipe.spaceHeight)
end