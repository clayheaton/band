require('colors')
require('states')

DecisionCard = class('DecisionCard')

DecisionCard.static.width = love.graphics.getWidth() * 0.8
DecisionCard.static.height = love.graphics.getHeight() * 0.7
DecisionCard.static.x = love.graphics.getWidth() * 0.1
DecisionCard.static.y = love.graphics.getHeight() * 0.1
DecisionCard.static.titleFont = love.graphics.newFont(20)
DecisionCard.static.bodyFont = love.graphics.newFont(14)
DecisionCard.static.cardColor = {255, 255, 255}
DecisionCard.static.titleColor = {0, 0, 0}
DecisionCard.static.bodyColor = {100, 100, 100}
DecisionCard.static.margin = 80
DecisionCard.static.offsetDefault = 0
DecisionCard.static.offsetRight = 0.2
DecisionCard.static.offsetLeft = -0.2


function DecisionCard:initialize(title, text)
  self.title = title
  self.text = text
  self.state = DecisionCardStateDefault
end

function DecisionCard:draw()

  local x = DecisionCard.x

  if self.state == DecisionCardStateRight then
    x = x + DecisionCard.offsetRight * love.graphics.getWidth()
  elseif self.state == DecisionCardStateLeft then
    x = x + DecisionCard.offsetLeft * love.graphics.getWidth()
  end

  -- Draw the card background
  setColor(DecisionCard.cardColor)
  love.graphics.rectangle("fill", x, DecisionCard.y, DecisionCard.width, DecisionCard.height)

  -- Draw the title
  setColor(DecisionCard.titleColor)
  love.graphics.setFont(DecisionCard.titleFont)
  love.graphics.printf(self.title, x, DecisionCard.y + 20, DecisionCard.width, "center")

  -- Draw the card body text
  setColor(DecisionCard.bodyColor)
  love.graphics.setFont(DecisionCard.bodyFont)
  love.graphics.printf(self.text, x + DecisionCard.margin, DecisionCard.y + 60, DecisionCard.width - 2 * DecisionCard.margin, "center")

end

function DecisionCard:shiftPosition(dir)
  if dir == "right" then
    if self.state == DecisionCardStateLeft then
      self.state = DecisionCardStateDefault
    elseif self.state == DecisionCardStateDefault then
      self.state = DecisionCardStateRight
    end
  elseif dir == "left" then
    if self.state == DecisionCardStateRight then
      self.state = DecisionCardStateDefault
    elseif self.state == DecisionCardStateDefault then
      self.state = DecisionCardStateLeft
    end
  end
end