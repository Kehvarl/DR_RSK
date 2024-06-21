require('app/menu.rb')

class GameOver < Menu

  def initialize args, bg=false
    super(args, bg)

    @title = "Robot Seeks Kitten"
    @menu = [["Start Over", :newgame_rsk],
             ["Exit", :exit]]
    @selected_index = 0
    @select_event = false
    @message = nil

    if bg
      @bg = bg
    else
      @bg = []
    end
  end

  def render
    out = @bg
    out << banner(@title)

    out << {x: 600, y: 550, text: "Game Over", size_enum: 2, **BANNER_COLORS[2][@frame]}.label!
    out << {x: 603, y: 547, text: "Game Over", size_enum: 1, **BANNER_COLORS[3][@frame]}.label!

    # Draw Menu Items
    @menu.each_with_index do |item, index|
      color = TEXT_COLOR
      if index == @selected_index
        color = HIGHLIGHT_COLOR
      end
      out << {x:540, y:500 - (index * 45), text: "#{index+1}: #{@menu[index][0]}", **color}.label!

      # Maybe animate some background stuff
    end
    out
  end
end
