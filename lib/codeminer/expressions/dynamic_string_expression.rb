class DynamicStringExpression < Expression

  def initialize(*body)
    @body = body
  end

  def type
    :dynamic_string
  end

  def each
    @body
  end

  def add(string)
    @body << string
    self
  end

end