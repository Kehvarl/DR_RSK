class Title
  TEXT_COLOR = {r:255, g:255, b:255}.freeze
  HIGHLIGHT_COLOR = {r:192, g:192, b:255}.freeze

  BANNER_COLORS = [
    [{r: 255, g: 0, b:0}, {r: 192, g: 0, b:0}, {r: 128, g: 0, b:0}, {r: 64, g: 0, b:0}, {r: 0, g: 0, b:0}],
    [{r: 255, g: 128, b:0}, {r: 192, g: 64, b:0}, {r: 128, g: 32, b:0}, {r: 64, g: 16, b:0}, {r: 0, g: 0, b:0}],
    [{r: 255, g: 255, b:0}, {r: 192, g: 192, b:0}, {r: 128, g: 128, b:0}, {r: 64, g: 64, b:0}, {r: 0, g: 0, b:0}],
    [{r: 255, g: 255, b:255}, {r: 192, g: 192, b:192}, {r: 128, g: 128, b:128}, {r: 64, g: 64, b:64}, {r: 32, g: 32, b:32}],
  ].freeze

  NUMBERS = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'].freeze

  attr_accessor :message, :select_event, :selected_index, :menu

  def initialize args, bg=false
    @frame = 0
    @frame_v = 1
    @frame_max = 3
    @frame_delay = 10

    @title = "Menu"
    @lines = [
      "Robot Seeks Kitten",
      "You're a robot who has lost their kitten.",
      "Adding insult to injury, your computer vision is on the fritz",
      "so it's difficult for you to tell what something really is",
      "until you get close enough to scan it more cleaely.",
      "Find your kitten so you feel better!",
      ""
    ]
    @selected_index = 0
    @select_event = false
    @message = nil

    if bg
      @bg = bg
    else
      @bg = []
    end
  end

  def tick args
    @select_event = false

    @frame_delay -=1
    if @frame_delay <= 0
      @frame += @frame_v
      if @frame > @frame_max or @frame < 0
        @frame_v = -@frame_v
        @frame += @frame_v
      end
      @frame_delay = 10
    end

    # On click/enter do something
  end

  def render
    @lines.each_with_index do |item, index|
      color = TEXT_COLOR
      out << {x:540, y:500 - (index * 45), text: "#{index+1}: #{@lines[index][0]}", **color}.label!

      # Maybe animate some background stuff
    end
    out
  end
end
