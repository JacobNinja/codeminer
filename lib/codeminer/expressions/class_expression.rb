class ClassExpression < Expression

  attr_reader :value, :body

  def initialize(name, body, src)
    @value = name
    @body = body
    @src = src
  end

  def type
    :class
  end

  def each
    [body]
  end

end