class StringEmbeddedExpression < Expression

  attr_reader :line, :column

  def initialize(body, src, line, column)
    @body = body
    @src = src
    @line = line
    @column = column
  end

  def each
    @body
  end

  def end_column
    @body.last.column + 1
  end

  def type
    :string_embexp
  end

end