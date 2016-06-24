
class MathProblem

  attr_reader :question, :answer

  REG = Proc.new { |x, y| [x, y, ""] }
  SUB = Proc.new { |x, y| (y > x) ? [y, x, ""] : [x, y, ""] }
  DIV = Proc.new { |x, y| (y > x) ? [y, x, " rounded down"] : [x, y, " rounded down"] }
  OPERATORS = {
    :+ => REG,
    :- => SUB,
    :* => REG,
    :/ => DIV,
    :** => REG
  }

  def initialize(operator, min_val, max_val)
    @min_val = min_val
    @max_val = max_val
    x = rand(@max_val-@min_val) + @min_val
    y = rand(@max_val-@min_val) + @min_val
    x,y,text_append = OPERATORS[operator].call(x, y)
    @question = "What is #{x} #{operator} #{y}" + text_append + "?"
    @answer = x.send(operator, y)
  end

end