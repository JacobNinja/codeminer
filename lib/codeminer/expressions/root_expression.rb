class RootExpression < Expression

  def initialize(body, src)
    @body = body
    @src = src
  end

  def each
    @body.each
  end

  def type
    :root
  end

end