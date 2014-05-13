class ReturnExpression < Expression

  def initialize(body, src)
    @body = body
    @src = src
  end

  def type
    :return
  end

  def body
    @body
  end

end