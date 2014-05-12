class DefnExpression < Expression

  attr_reader :value, :params

  def initialize(name, params, body, src)
    @value = name
    @params = params
    @body = body
    @src = src
  end

  def type
    :defn
  end

  def each
    @body.each
  end

end