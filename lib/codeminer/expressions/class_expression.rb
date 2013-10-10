class ClassExpression

  attr_reader :value, :body, :src

  def initialize(name, body, src)
    @value = name
    @body = body
    @src = src
  end

  def type
    :class
  end

  def children
    body.children.to_a
  end

end