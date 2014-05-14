class ParamsContainer < Expression

  def initialize(body, src)
    @body = body
    @src = src
  end

  def type
    :params
  end

  def each
    @body
  end

end