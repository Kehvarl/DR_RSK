require('app/anim_sprite.rb')


class Cat < AnimSprite
  def initialize (x,y)
    super(x,y)
    @path= "sprites/sheets/cat.png"

    @current_pose = :idle_lick
    @pose_list = {
      sit_down: [0,4,4, [:sit_down, :idle_lick, :idle_sleep]],
      sit_right: [1,4,4, [:sit_right, :idle_lick, :idle_sleep]],
      idle_lick: [2,4,2, [:idle_lick, :idle_ear, :idle_sleep, :arch]],
      idle_ear: [3,4,1, [:idle_lick, :idle_sleep, :arch]],
      walk: [4,8,1, [:sit_down, :pat]],
      leap: [5,8,1, [:sit_down]],
      idle_sleep: [6,4,4, [:idle_sleep, :idle_ear, :idle_sleep, :arch]],
      pat: [7,6,1, [:sit_down]],
      pounce: [8,7,1, [:sit_down]],
      arch: [9,8,1, [:sit_down]]
    }
  end
end

class Crab < AnimSprite
  def initialize (x,y)
    super(x,y)
    @path= "sprites/sheets/crab.png"
    @current_pose = :idle
    @pose_list = {
      idle: [0,4,4, [:idle]],
      walk: [1,4,1, [:idle]],
      die: [2,4,1, [:idle]],
      attack: [3,4,1, [:idle]]
    }
  end
end

class Fox < AnimSprite
  def initialize (x,y)
    super(x,y)
    @path= "sprites/sheets/fox.png"

    @current_pose = :idle
    @pose_list = {
      idle: [0,5,4, [:idle, :idle_look]],
      idle_look: [1,14,1, [:idle, :idle_look, :fear, :sleep]],
      walk: [2,8,1, [:idle]],
      attack: [3,11,1, [:idle]],
      fear: [4,5,1, [:idle]],
      sleep: [5,6,3, [:sleep, :idle]],
      die: [6,7,1, [:idle]]
    }
  end
end

class Armadillo < AnimSprite
  def initialize (x,y)
    super(x,y)
    @path= "sprites/sheets/armadillo.png"

    @current_pose = :idle
    @pose_list = {
      idle: [0,8,2, [:idle, :idle_ball]],
      walk: [1,4,1, [:idle]],
      idle_ball: [2,8,1, [:idle, :duck, :die]],
      duck: [3,3,1, [:idle]],
      die: [4,3,1, [:idle]]
    }
  end
end

class Squirrel < AnimSprite
  def initialize (x,y)
    super(x,y)
    @path= "sprites/sheets/squirrel.png"

    @current_pose = :idle
    @pose_list = {
      idle: [0,6,2, [:idle, :idle_look, :idle_forage]],
      idle_look: [1,6,1, [:idle, :idle_look, :idle_nibble]],
      walk: [2,8,1, [:idle]],
      idle_forage: [3,4,1, [:idle]],
      idle_nibble: [4,2,1, [:idle]],
      fear: [5,4,1, [:idle]],
      die: [6,4,1, [:idle]]
    }
  end
end
