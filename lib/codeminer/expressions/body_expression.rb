class BodyExpression < Expression

  def initialize(*body)
    @body = body
  end

  def add(statement)
    @body << statement
    self
  end

  def each
    @body
  end

  def type
    :body
  end

  def line
    @body.first.line
  end

  def column
    @body.first.column
  end

  def end_line
    @body.last.end_line
  end

  def end_column
    @body.last.end_column
  end

end