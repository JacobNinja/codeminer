class UnknownExpression < Expression

  attr_reader :type, :value, :line, :column

  def initialize(type, value, src, children, line, column)
    @type, @value, @src, @children, @line, @column = type, value, src, children, line, column
  end

  def <<(obj)
    @children << obj
  end

  def each
    @children
  end

  def end_column
    column
  end

end