require('main')

-- Callbacks for button presses that affect scene transitions
-- This may need to move to be in the proper scope.
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
