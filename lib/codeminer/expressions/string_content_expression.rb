class StringContentExpression

  attr_reader :line, :column

  def initialize(line, column)
    @line = line
    @column = column
  end

  def add(string, src, line, column)
    if string.kind_of? StringEmbeddedExpression
      DynamicStringExpression.new(string, src, @line, @column)
    else
      StringExpression.new(string, src)
    end
  end

end