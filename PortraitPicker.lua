require('colors')

PortraitPicker = class('PortraitPicker')

PortraitPicker.static.titleFont = love.graphics.newFont(36)
PortraitPicker.static.bodyFont = love.graphics.newFont(18)
PortraitPicker.static.titleColor = {255, 255, 255}
PortraitPicker.static.bodyColor = {255, 255, 255}

function PortraitPicker:initialize(event_table)
  self.type = "PortraitPicker"
  self.main_title = event_table['main_title']
  self.body_text = event_table['body_text']
  self.card_image = event_table['card_image']
  self.attr_to_set = event_table['attr_to_set']

  self.portraits = {}

  for i = 1, 6 do
    local p_path = "sprites/portraits/portrait" .. i .. ".png"
    local portrait = love.graphics.newImage(p_path)
    local portrait_pack = {}
    portrait_pack.num = i
    portrait_pack.path = p_path
    portrait_pack.image = portrait
    table.insert(self.portraits, portrait_pack)
  end

end

function PortraitPicker:draw()
  -- Draw the title text for the stage
  love.graphics.setFont(TextInputScreen.titleFont)
  setColor(TextInputScreen.titleColor)
  love.graphics.printf(self.main_title, 0, 50, love.graphics:getWidth(), "center")

  -- Draw the descriptive text
  love.graphics.setFont(TextInputScreen.bodyFont)
  setColor(TextInputScreen.bodyColor)
  love.graphics.printf(self.body_text, 0, 100, love.graphics:getWidth(), "center")

  -- Draw the portraits
  -- For now, they are all 300 x 350
  for i, portrait in ipairs(self.portraits) do
    local p = self.portraits[i]
    love.graphics.draw(p.image, (((i - 1)%3 + 1) * 150) - 75, math.ceil(i / 3) * p.image:getHeight() / 2, nil, 0.5, 0.5)
  end

end

function PortraitPicker:keypressed(key, scancode, isrepeat)

end

function PortraitPicker:textinput(t)

end

function PortraitPicker:mousepressed(x, y, button, isTouch)

end
