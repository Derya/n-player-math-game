

class Player
  def initialize(name, playerNum)
    @name = name.split(/ |\_/).map(&:capitalize).join(" ")
    @careerScore = 0
    @gamesWon = 0
    @playerNum = playerNum
  end

  attr_reader :playerNum, :score, :lives, :gamesWon, :careerScore, :name

  def reset(lives)
    @score = 0
    @lives = lives
  end
  def removeLife
    @lives -= 1
  end
  def addWin
    @gamesWon += 1
  end
  def addScore
    @careerScore += 1
    @score += 1
  end
  def isAlive?
    @lives > 0
  end
  
end