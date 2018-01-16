--[[
  Hosts the code to walk through the choices that a player has to make
  when starting a new game and creating a character.
]]

require('states')
require('colors')
require('Scene')
require('Button')
require('Card')
require('TextInputScreen')
require('PersonalityGenerator')
require('PortraitPicker')
require('reference_tables')

CreateCharacterScene = class('CreateCharacterScene', Scene)

function CreateCharacterScene:initialize(scene_name, stages)
  Scene.initialize(self, scene_name)
  print(self.name .. " CreateCharacterScene initialized.")

  self.scene_name = scene_name
  self.buttons = {}
  self.title_font = love.graphics.newFont(18)
  self.active_stage_number = 1
  self.stage_data = stages
  self.stages = {}

  -- Generate the stages for this scene
  for i = 1, #stages, 1 do
    local s = self.stage_data[i]
    local s_type = s['stage_type']

    print(s)

    if s_type == 'Card' then
      local stage = Card(s, CreateCharacterGenderSelected)
      table.insert(self.stages, stage)
    elseif s_type == 'TextInputScreen' then
      local stage = TextInputScreen(s, CreateCharacterAdvanceStage) --CreateCharacterTextInputScreenReturn)
      table.insert(self.stages, stage)
    elseif s_type == 'PersonalityGenerator' then
      local stage = PersonalityGenerator(s)
      table.insert(self.stages, stage)
    elseif s_type == 'PortraitPicker' then
      local stage = PortraitPicker(s)
      table.insert(self.stages, stage)
    end
  end

  self.max_stages = #self.stages
  self.active_stage = self.stages[1]

  local winW = love.graphics.getWidth()
  local winH = love.graphics.getHeight()

  local button_font = love.graphics.newFont(18)
  self.button_next = Button("button_next", "Next", {80, 80, 255}, color_white, button_font, CreateCharacterAdvanceStage, winW * 0.75, winH * 0.9, winW * 0.2, winH * 0.08)
  self.button_back = Button("button_back", "Back", {255, 80, 80}, color_white, button_font, CreateCharacterGoBackStage, winW * 0.25 - winW * 0.2, winH * 0.9, winW * 0.2, winH * 0.08)
  self.button_complete = Button("button_complete", "Finish!", {73, 129, 69}, color_white, button_font, CreateCharacterFinish, winW * 0.75, winH * 0.9, winW * 0.2, winH * 0.08)
end

function CreateCharacterScene:update(dt)

end

function CreateCharacterScene:draw()
  setColor(color_white)
  love.graphics.setFont(self.title_font)
  love.graphics.printf(self.scene_name, 0, 20, love.graphics.getWidth(), "center")

  self.active_stage:draw()

  if self.active_stage_number > 1 then
    self.button_back:draw()
  end

  if self.active_stage_number < #self.stages then
    self.button_next:draw()
  end

  if self.active_stage_number == #self.stages then
    self.button_complete:draw()
  end
end

-- Navigating stages of character creation
function CreateCharacterScene:advanceStage()
  -- make sure to save before continuing
  if self.active_stage_number < # self.stages then
    self.active_stage_number = self.active_stage_number + 1
    self.active_stage = self.stages[self.active_stage_number]
  end
end

function CreateCharacterScene:goBackStage()
  if self.active_stage_number > 1 then
    self.active_stage_number = self.active_stage_number - 1
    self.active_stage = self.stages[self.active_stage_number]
  end
end

function CreateCharacterScene:finishCharacter()
  -- If any of the text inputs are missing values, randomize.
  for i = 1, #self.stages, 1 do
    local s = self.stages[i]
    if s.type == "TextInputScreen" then
      s:ifBlankAssignRandom()
    elseif s.type == "Card" then
      s:randomizeValueIfNil()
    end
  end
end

-- Catching key and mouse events
function CreateCharacterScene:textinput(t)
  self.active_stage:textinput(t)
end

function CreateCharacterScene:keypressed(key, scancode, isrepeat)
  self.active_stage:keypressed(key, scancode, isrepeat)

  print(key .. " pressed: CreateCharacterScene default behavior")
end

function CreateCharacterScene:mousepressed(x, y, button, isTouch)
  -- Check if Back or Next buttons are clicked
  if button == 1 then
    if self.active_stage_number > 1 then
      local hit = self.button_back:catchMousePressedEvent(x, y)
      if hit then
        return
      end
    end
    if self.active_stage_number < # self.stages then
      local hit = self.button_next:catchMousePressedEvent(x, y)
      if hit then
        return
      end
    end
    if self.active_stage_number == # self.stages then
      local hit = self.button_complete:catchMousePressedEvent(x, y)
      if hit then
        return
      end
    end
  end
end
