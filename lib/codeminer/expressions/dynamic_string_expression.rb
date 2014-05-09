class DynamicStringExpression < Expression

  attr_reader :line, :column

  def initialize(*body, src, line, column)
    @body = body
    @src = src
    @line = line
    @column = column
  end

  def type
    :dynamic_string
  end

  def each
    @body
  end

  def add_quotes(src)
    DynamicStringExpression.new(*@body, src, @line, @column)
  end

  def add(string, src, line, column)
    DynamicStringExpression.new(*[*@body, *string], src, line, column)
  end

end