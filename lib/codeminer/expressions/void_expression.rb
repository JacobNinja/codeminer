class VoidExpression < Expression

  attr_reader :line, :column

  def initialize(line, column)
    @line = line
    @column = column
  end

  def end_line
    line
  end

  def end_column
    column
  end

  def type
    :void_stmt
  end

  def each
    []
  end

end