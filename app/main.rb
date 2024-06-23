require('app/title.rb')
require('app/main_menu.rb')
require('app/game.rb')
require('app/rsk.rb')
require('app/game_over.rb')

def setup args
  args.state.game_state = :main_menu
  args.state.title = Title.new({})
  args.state.title_seen = false
  args.state.main_menu = MainMenu.new({})
  args.state.over_menu = GameOver.new({})
end

def title_tick args
    args.state.title.tick(args)
    args.outputs.primitives << args.state.title.render
    if args.state.title.continue == true
      args.state.title_seen = true
      args.state.game_state = :newgame_rsk
    end
end

def main_menu_tick args
  args.state.main_menu.tick args
  args.outputs.primitives << args.state.main_menu.render
  if args.state.main_menu.select_event
    puts args.state.main_menu.message
  elsif args.state.main_menu.message == :newgame_rsk
    if args.state.title_seen == false
      args.state.game_state = :title
    else
      args.state.game = Rsk.new(args)
      args.state.game_state = :game
    end
  elsif args.state.main_menu.message == :continue
    args.state.game_state = :game
  end
end


def game_over_tick args
  args.state.game_over.tick args
  args.outputs.primitives << args.state.game_over.render

  if args.state.game_over.select_event
    puts args.state.game_over.message
  elsif args.state.game_over.message == :newgame_rsk
    args.state.game = Rsk.new(args)
    args.state.game_state = :game
  elsif args.state.game_over.message == :continue
    args.state.game_state = :game
  end
end

def tick args
  if args.tick_count == 0
    setup args
  end

  args.outputs.primitives << {x:0, y:0, w:1280, h:720, r:0, g:0, b:0}.solid!

  case args.state.game_state
  when :title
    title_tick args
  when :main_menu
    main_menu_tick args
  when :pause_menu
    main_menu_tick args
  when :game
    args.state.game.tick args
    args.outputs.primitives << args.state.game.render()
  when :player
    args.state.game_state = :enemy
  when :enemy
    args.state.game_state = :player
  when :game_over
    args.state.game_over = GameOver.new({}, bg=args.state.game.render())
    args.state.game_state = :game_over_tick
  when :game_over_tick
    game_over_tick args
  end
end
