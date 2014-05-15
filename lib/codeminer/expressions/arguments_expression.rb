class ArgumentsExpression < Expression

  def initialize(*arguments)
    @arguments = arguments
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