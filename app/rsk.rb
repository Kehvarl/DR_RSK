require('app/game.rb')
require('app/game_sprites.rb')

class Entity
  attr_accessor  :x, :y, :w, :h, :is_cat

  def initialize(x,y,type,disguise)
    @creature = create(x,y,type)
    @disguise = create(x,y,disguise)
    @in_disguise = true
    @is_cat = (type == :cat)
    @x = x
    @y = y
    @w = @disguise.w
    @h = @disguise.h
  end

  def create(x,y,type)
    case type
    when :cat
      e = Cat.new(x,y)
      @is_cat = true
    when :armadillo
      e = Armadillo.new(x,y)
    when :crab
      e =  Crab.new(x,y)
    when :fox
      e = Fox.new(x,y)
    when :squirrel
      e = Squirrel.new(x,y)
    end
    return e
  end

  def uncover
    @creature.x = @disguise.x
    @creature.y = @disguise.y
    @creature.dx = @disguise.dx
    @creature.dy = @disguise.dy
    @creature.moving = false
    @in_disguise = false
  end

  def check_collisions(entities)
    if @in_disguise
      return @disguise.check_collisions(entities)
    else
      return @creature.check_collisions(entities)
    end
  end

  def tick(args, entities)
    if @in_disguise
      @disguise.tick(args, entities)
      @x = @disguise.x
      @y = @disguise.y
    else
      @creature.tick(args, entities)
      @x = @creature.x
      @y = @creature.y
    end
  end

  def render
    if @in_disguise
      return @disguise
    end
    return @creature
  end

  def intersect_rect?(other, tolerance)
    return @disguise.intersect_rect?(other, tolerance)
  end
end

class Rsk < Game
  def initialize args={tick_count:0}
    @start_tick = args.tick_count
    @robot = Player.new(623, 352, is_player=true)
    @entities = new_entities(15)
    @kitten_found = false
  end

  def new_entities(count)
    out = []
    while out.size() < count
      type = [:armadillo, :crab, :fox, :squirrel].sample
      disguise = ([:armadillo, :crab, :fox, :squirrel, :cat]-[type]).sample
      x = rand(1216)
      y = rand(656)

      e = Entity.new(x, y, type, disguise)

      if not out.any_intersect_rect?(e)
        out << e
      end
    end

    x = rand(1216)
    y = rand(656)
    out << Entity.new(x, y, :cat, [:armadillo, :crab, :fox, :squirrel].sample)

    out
  end

  def tick args
    if args.tick_count - @start_tick < 10
      return
    end
    super(args)
    @entities.each { |e| e.tick(args, @entities) }

    if args.inputs.last_active == :keyboard
      if args.inputs.keyboard.key_held.up
        @robot.y += @robot.vy
        @robot.angle = 90
      elsif args.inputs.keyboard.key_held.down
        @robot.y -= @robot.vy
        @robot.angle = 270
      elsif args.inputs.keyboard.key_held.left
        @robot.x -= @robot.vx
        @robot.angle = 180
      elsif args.inputs.keyboard.key_held.right
        @robot.x += @robot.vx
        @robot.angle = 0
      end
    elsif args.inputs.last_active == :mouse and args.inputs.mouse.button_left
      @robot.move_to(args.inputs.mouse.x, args.inputs.mouse.y)
    end

    @robot.tick(args, @entities)

    collisions = @entities.select{|e| @robot.intersect_rect?(e)}
    collisions.each do |c|
      c.uncover()
      if c.is_cat
        @kitten_found = true
        args.state.game_state = :game_over
      end
    end

  end

  def render
    out = []
    out << @robot
    #out << @entities
    @entities.each {|c| out << c.render() }

    out
  end
end
