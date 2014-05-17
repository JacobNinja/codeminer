class ArgumentsExpression < Expression

  attr_reader :end_line, :end_column, :value

  def initialize(*arguments, end_line, end_column)
    @arguments = arguments
    @end_line = end_line
    @end_column = end_column
  end

  def add(exp)
    @arguments << exp
    self
  end

  def type
    :arguments
  end

  def each
    @arguments
  end

end