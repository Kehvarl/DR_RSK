require('app/menu.rb')

class MainMenu < Menu
  def initialize args, bg=false
    super(args, bg)

    @title = "Robot Seeks Kitten"
    @menu = [["New Game", :newgame_rsk],
             ["Exit", :exit]]
    @selected_index = 0
    @select_event = false
    @message = nil
  end
end
