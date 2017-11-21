function love.load()
    bird = {}
    bird.y = 200
    bird.ySpeed = 0
    g = 500
end

function love.update(dt)
    bird.ySpeed = bird.ySpeed + (g * dt)
    bird.y = bird.y + (bird.ySpeed * dt)
end

function love.draw()
    love.graphics.setColor(31, 97, 127)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(255, 215, 63)
    love.graphics.rectangle('fill', 65, bird.y, 30, 25)
end