--[[
  These functions are used as callbacks for the Button class
]]

require('main')
require('convenience')

function startNewGame()
  print("startNewGame() called from buttonclick callback in TitleScene")
  active_scene = character_scene
end

-- Quit the game
-- Perform any necessary prompting or cleanup here.
-- Called when clicking on the Quit button
function quitGame()
  love.event.quit()
end

-- Callbacks for CreateCharacterScene
function CreateCharacterAdvanceStage()
  active_scene:advanceStage()
end

function CreateCharacterGoBackStage()
  active_scene:goBackStage()
end

function CreateCharacterFinish()
  active_scene:finishCharacter()
end

function CreateCharacterGenderSelected(card)
  CreateCharacterAdvanceStage()
  card:centerPosition()
end

function CreateCharacterTextInputScreenReturn(stage)
  -- Check for random and fill the value if it's an empty string
  if trim(stage.input_text) == "" then
    PickRandomName(stage)
  end
  CreateCharacterAdvanceStage()
end

function PickRandomName(stage)
  if stage.attr_to_set == "first_name" then
    stage.input_text = unisex_names[ math.random(#unisex_names) ]
  elseif stage.attr_to_set == "last_name" then
    stage.input_text = last_names[ math.random(#last_names) ]
  elseif stage.attr_to_set == "home_town" then
    stage.input_text = home_towns[ math.random(#home_towns) ]
  end
end
