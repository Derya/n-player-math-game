

class MathProblem

  def initialize(typeID, minVal, maxVal)
    @minVal = minVal
    @maxVal = maxVal
    case typeID
    when :add
      addQuestion
    when :sub
      subQuestion
    when :mult
      multQuestion
    when :div
      divQuestion
    end
  end

  attr_reader :question, :answer

  def addQuestion
    x = rand(@maxVal-@minVal) + @minVal
    y = rand(@maxVal-@minVal) + @minVal
    @question = "What is #{x.to_i} + #{y.to_i}?"
    @answer = x + y
  end
  def subQuestion
    x = rand(@maxVal-@minVal) + @minVal
    y = rand(@maxVal-@minVal) + @minVal
    if (y > x)
      x,y = y,x
    end
    @question = "What is #{x.to_i} - #{y.to_i}?"
    @answer = x - y
  end
  def multQuestion
    x = rand(@maxVal-@minVal) + @minVal
    y = rand(@maxVal-@minVal) + @minVal
    @question = "What is #{x.to_i} * #{y.to_i}?"
    @answer = x * y
  end
  # haha, i sure hope @minVal is above 0 
  def divQuestion
    x = rand(@maxVal-@minVal) + @minVal
    y = rand(@maxVal-@minVal) + @minVal
    if (y > x)
      x,y = y,x
    end
    @question = "What is #{x.to_i} / #{y.to_i} rounded down?"
    @answer = x / y
  end

end