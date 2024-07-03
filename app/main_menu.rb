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

  def render
    out = []
    #out << {x: 521, y: 641, text: @title, size_enum: 1, **BANNER_COLORS[1][0]}.label!#[@frame]}.label!
    out << {x: 423, y:400, w:434, h:278, path:"sprites/misc/rsk.png"}.sprite!

    # Draw Menu Items
    @menu.each_with_index do |item, index|
      color = TEXT_COLOR
      if index == @selected_index
        color = HIGHLIGHT_COLOR
      end
      out << {x:400, y:380 - (index * 30), text: "#{index+1}: #{@menu[index][0]}", **color}.label!

      # Maybe animate some background stuff
    end
    out << @cat
    out << @robot
    out
  end
end
