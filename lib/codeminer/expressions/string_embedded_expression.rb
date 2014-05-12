class StringEmbeddedExpression < Expression

  def initialize(body, src)
    @body = body
    @src = src
  end

  def each
    @body
  end

  def type
    :string_embexp
  end

end