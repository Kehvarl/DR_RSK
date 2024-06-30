require('app/menu.rb')
require('app/game_sprites.rb')

class GameOver < Menu

  def initialize args, bg=false
    super(args, bg)

    @title = "Robot Seeks Kitten"
    @menu = [["Start Over", :newgame_rsk],
             ["Exit", :exit]]
    @selected_index = 0
    @select_event = false
    @message = nil

    @cat = Cat.new(648, 400)
    @cat.flip_horizontally = true
    @heart = Heart.new(632, 424)
    @robot = Player.new(596, 400, false)

    if bg
      @bg = bg
    else
      @bg = []
    end
  end

  def tick args
    super(args)
    @cat.tick(args, [@cat], false)
    @heart.tick(args, [@heart], false)
    @robot.tick(args, [@robot], false)
  end

  def render
    out = [] #@bg
    out << banner(@title)

    out << @cat
    out << @heart
    out << @robot

    out << {x: 580, y: 550, text: "Kitten Found!", size_enum: 2, **BANNER_COLORS[2][@frame]}.label!
    out << {x: 584, y: 547, text: "Kitten Found!", size_enum: 1, **BANNER_COLORS[3][@frame]}.label!

    # Draw Menu Items
    @menu.each_with_index do |item, index|
      color = TEXT_COLOR
      if index == @selected_index
        color = HIGHLIGHT_COLOR
      end
      out << {x:540, y:360 - (index * 45), text: "#{index+1}: #{@menu[index][0]}", **color}.label!

      # Maybe animate some background stuff
    end
    out
  end
end
