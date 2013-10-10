class RootExpression

  attr_reader :src

  def initialize(body, src)
    @body = body
    @src = src
  end

  def children
    @body
  end

  def type
    :root
  end

end