--[[
  Middleclass class library: https://github.com/kikito/middleclass
]]

function love.load()
  love.window.setMode(600, 800)
  require('libraries/table_utils')
  class = require('libraries/middleclass-master/middleclass')
  ftcsv = require('libraries/ftcsv')

  events, headers = ftcsv.parse('data/events.csv', ",")

  print(table.tostring(events))

  require('DecisionCard')

  card = DecisionCard(events[2])
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
