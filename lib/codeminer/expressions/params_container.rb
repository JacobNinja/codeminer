class ParamsContainer < Expression

  attr_reader :type, :value

  def initialize(body, type, src)
    @body = body
    @type = type
    @src = src
  end

  def each
    @body
  end

end