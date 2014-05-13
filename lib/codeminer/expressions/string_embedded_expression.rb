class StringEmbeddedExpression < Expression

  def initialize(body, src)
    @body = body
    @src = src
  end

  def each
    @body.each
  end

  def type
    :string_embexp
  end

end