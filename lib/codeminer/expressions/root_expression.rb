class RootExpression < Expression

  def initialize(body, src)
    @body = body
    @src = src
  end

  def each
    Array(@body)
  end

  def type
    :root
  end

end