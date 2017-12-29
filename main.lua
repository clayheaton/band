--[[
  Middleclass class library: https://github.com/kikito/middleclass
]]

function love.load()
  love.window.setMode(600, 800)
  class = require('libraries/middleclass-master/middleclass')

  require('DecisionCard')

  card = DecisionCard("Decision Card Main Title", "Some text in the card should display wrapped if that is an issue that has to be handled.", "decision_card_test.png")
end

function love.update(dt)

end

function love.draw()
  card:draw()
end

function love.keypressed(key, scancode, isrepeat)

  if key == "right" then
    card:shiftPosition("right")
  elseif key == "left" then
    card:shiftPosition("left")
  end

end
