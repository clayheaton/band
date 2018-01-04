--[[
  Parent class for several card types.
]]

require('colors')
require('states')

Card = class('Card')

Card.static.width = love.graphics.getWidth() * 0.8
Card.static.height = love.graphics.getHeight() * 0.75
Card.static.x = love.graphics.getWidth() * 0.1
Card.static.y = love.graphics.getHeight() * 0.1
Card.static.titleFont = love.graphics.newFont(20)
Card.static.bodyFont = love.graphics.newFont(14)
Card.static.cardColor = {255, 255, 255}
Card.static.titleColor = {0, 0, 0}
Card.static.bodyColor = {100, 100, 100}
Card.static.margin = 80
Card.static.offsetDefault = 0
Card.static.offsetRight = 0.2
Card.static.offsetCommitRight = 0.8 -- change to off screen eventually
Card.static.offsetLeft = -0.2
Card.static.offsetCommitLeft = -0.8 -- change to off screen eventually


function Card:initialize(event_table)

  self.title = event_table['main_title']
  self.text = event_table['body_text']
  self.state = CardStateDefault
  local imageloc

  if event_table['card_image'] == '' then
    imageloc = "sprites/400x300.png"
  else
    imageloc = "sprites/decision_card_images/" .. event_table['card_image']
  end

  self.image = love.graphics.newImage(imageloc)
end

function Card:draw()

  -- The state of the card determines where it should be drawn
  local x = Card.x

  if self.state == CardStateRight then
    x = x + Card.offsetRight * love.graphics.getWidth()
  elseif self.state == CardStateLeft then
    x = x + Card.offsetLeft * love.graphics.getWidth()
  elseif self.state == CardStateCommitRight then
    x = x + Card.offsetCommitRight * love.graphics.getWidth()
  elseif self.state == CardStateCommitLeft then
    x = x + Card.offsetCommitLeft * love.graphics.getWidth()
  end

  -- Draw the card background
  setColor(Card.cardColor)
  love.graphics.rectangle("fill", x, Card.y, Card.width, Card.height)

  -- Draw the card image - scaling depends on whether the image was captured on a retina screen
  -- Card images should be 400 x 300
  if self.image:getWidth() == 400 then
    love.graphics.draw(self.image, x + Card.width / 2, Card.y + 100, nil, nil, nil, self.image:getWidth() / 2, nil)
  else
    love.graphics.draw(self.image, x + Card.width / 2, Card.y + 100, nil, 0.5, 0.5, self.image:getWidth() / 2, nil)
  end

  -- Draw the title
  setColor(Card.titleColor)
  love.graphics.setFont(Card.titleFont)
  love.graphics.printf(self.title, x, Card.y + 20, Card.width, "center")

  -- Draw the card body text
  setColor(Card.bodyColor)
  love.graphics.setFont(Card.bodyFont)
  love.graphics.printf(self.text, x + Card.margin, Card.y + 60, Card.width - 2 * Card.margin, "center")

end

function Card:shiftPosition(dir)
  if dir == "right" then
    if self.state == CardStateLeft then
      self.state = CardStateDefault
    elseif self.state == CardStateDefault then
      self.state = CardStateRight
    elseif self.state == CardStateRight then
      self.state = CardStateCommitRight
    end
  elseif dir == "left" then
    if self.state == CardStateRight then
      self.state = CardStateDefault
    elseif self.state == CardStateDefault then
      self.state = CardStateLeft
    elseif self.state == CardStateLeft then
      self.state = CardStateCommitLeft
    end
  end
end
