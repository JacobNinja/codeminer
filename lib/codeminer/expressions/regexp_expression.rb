class RegexpExpression < Expression

  def initialize(content, end_token, src)
    @content = content
    @end_token = end_token
    @src = src
  end

  def type
    :regexp
  end

  def value
    @content.value
  end

end