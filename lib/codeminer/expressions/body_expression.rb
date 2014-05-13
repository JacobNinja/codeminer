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

end