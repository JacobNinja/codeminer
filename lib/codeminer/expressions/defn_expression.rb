class DefnExpression

  attr_reader :value, :src

  def initialize(name, src, body)
    @value = name
    @src = src
    @body = body
  end

  def type
    :defn
  end

  def children
    @body.children
  end

end