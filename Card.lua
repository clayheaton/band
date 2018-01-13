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
Card.static.offsetDown = -0.2
Card.static.offsetCommitDown = -0.8 -- change to off screen eventually


function Card:initialize(event_table, callback_on_commit)

  self.title = event_table['main_title']
  self.text = event_table['body_text']
  self.state = CardStateDefault
  self.callback = callback_on_commit

  local imageloc

  if event_table['card_image'] == '' then
    imageloc = "sprites/400x300.png"
  else
    imageloc = "sprites/" .. event_table['card_image']
  end

  self.image = love.graphics.newImage(imageloc)
end

function Card:draw()

  -- The state of the card determines where it should be drawn
  local x = Card.x
  local y = Card.y

  if self.state == CardStateRight then
    x = x + Card.offsetRight * love.graphics.getWidth()
  elseif self.state == CardStateLeft then
    x = x + Card.offsetLeft * love.graphics.getWidth()
  elseif self.state == CardStateDown then
    y = y - Card.offsetDown * love.graphics.getHeight()
  elseif self.state == CardStateCommitRight then
    x = x + Card.offsetCommitRight * love.graphics.getWidth()
  elseif self.state == CardStateCommitLeft then
    x = x + Card.offsetCommitLeft * love.graphics.getWidth()
  elseif self.state == CardStateCommitDown then
    y = y - Card.offsetCommitDown * love.graphics.getHeight()
  end

  -- Draw the card background
  setColor(Card.cardColor)
  love.graphics.rectangle("fill", x, y, Card.width, Card.height)

  -- Draw the card image - scaling depends on whether the image was captured on a retina screen
  -- Card images should be 400 x 300
  if self.image:getWidth() == 400 then
    love.graphics.draw(self.image, x + Card.width / 2, y + 100, nil, nil, nil, self.image:getWidth() / 2, nil)
  else
    love.graphics.draw(self.image, x + Card.width / 2, y + 100, nil, 0.5, 0.5, self.image:getWidth() / 2, nil)
  end

  -- Draw the title
  setColor(Card.titleColor)
  love.graphics.setFont(Card.titleFont)
  love.graphics.printf(self.title, x, y + 20, Card.width, "center")

  -- Draw the card body text
  setColor(Card.bodyColor)
  love.graphics.setFont(Card.bodyFont)
  love.graphics.printf(self.text, x + Card.margin, y + 60, Card.width - 2 * Card.margin, "center")

end

function Card:keypressed(key, scancode, isrepeat)
  self:shiftPosition(key)
end

function Card:centerPosition()
  self.state = CardStateDefault
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
  elseif dir == "down" then
    if self.state == CardStateDefault then
      self.state = CardStateDown
    elseif self.state == CardStateDown then
      self.state = CardStateCommitDown
    end
  elseif dir == "up" then
    if self.state == CardStateDown then
      self.state = CardStateDefault
    end
  end

  if self.state == CardStateCommitRight then
    print("Card committed Right")
    self.callback(self)
  elseif self.state == CardStateCommitLeft then
    print("Card committed Left")
    self.callback(self)
  elseif self.state == CardStateCommitDown then
    print("Card committed Down")
    self.callback(self)
  end
end
