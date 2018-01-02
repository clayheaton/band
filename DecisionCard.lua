require('colors')
require('states')

DecisionCard = class('DecisionCard')

DecisionCard.static.width = love.graphics.getWidth() * 0.8
DecisionCard.static.height = love.graphics.getHeight() * 0.75
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


function DecisionCard:initialize(event_table)

  self.title = event_table['main_title']
  self.text = event_table['body_text']
  self.state = DecisionCardStateDefault
  local imageloc

  if event_table['card_image'] == '' then
    imageloc = "sprites/decision_card_images/default_card_image.png"
  else
    imageloc = "sprites/decision_card_images/" .. event_table['card_image']
  end

  self.image = love.graphics.newImage(imageloc)
end

function DecisionCard:draw()

  -- The state of the card determines where it should be drawn
  local x = DecisionCard.x

  if self.state == DecisionCardStateRight then
    x = x + DecisionCard.offsetRight * love.graphics.getWidth()
  elseif self.state == DecisionCardStateLeft then
    x = x + DecisionCard.offsetLeft * love.graphics.getWidth()
  end

  -- Draw the card background
  setColor(DecisionCard.cardColor)
  love.graphics.rectangle("fill", x, DecisionCard.y, DecisionCard.width, DecisionCard.height)

  -- Draw the card image - scaling depends on whether the image was captured on a retina screen
  -- Card images should be 400 x 300
  if self.image:getWidth() == 400 then
    love.graphics.draw(self.image, x + DecisionCard.width / 2, DecisionCard.y + 100, nil, nil, nil, self.image:getWidth() / 2, nil)
  else
    love.graphics.draw(self.image, x + DecisionCard.width / 2, DecisionCard.y + 100, nil, 0.5, 0.5, self.image:getWidth() / 2, nil)
  end

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
