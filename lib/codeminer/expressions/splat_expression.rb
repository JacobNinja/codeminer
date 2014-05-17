class SplatExpression < Expression

  def initialize(body, src)
    @body = body
    @src = src
  end

  def type
    :splat
  end

  def value
    @body.value
  end

  def each
    @body.each
  end

end