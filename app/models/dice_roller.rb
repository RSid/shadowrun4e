class DiceRoller
  include ActiveModel::Model
  attr_accessor :glitch, :critical_glitch, :successes

  def initialize
    @critical_glitch = false
    @glitch = false
    @successes = 0
  end

  def roll_skill(characterskill, modifier = nil)
    @results = []

    if modifier
      dice_pool = characterskill.rating
        + characterskill.character.(characterskill.skill.default_skill)
        + modifier
    else
      dice_pool = characterskill.rating
        + characterskill.character.(characterskill.skill.default_skill)
    end

    dice_pool.times {@results << rand(1..6)}

    @successes = @results.count{ |x| x >= 4 }

    if @results.count(1) >= @results.count/2
      if @successes == 0
        @critical_glitch = true
      else
        @glitch = true
      end
    end
    @results
  end

  def roll(dice)
    @results = []

    dice.times {@results << rand(1..6)}

    @successes = @results.count{ |x| x >= 4 }

    if @results.count(1) >= @results.count/2
      if @successes == 0
        @critical_glitch = true
      else
        @glitch = true
      end
    end
    @results
  end
end
