class ClassVariableExpression < Expression

  attr_reader :value

  def initialize(value, src)
    @value = value
    @src = src
  end

  def type
    :class_variable
  end

  def each
    []
  end

end