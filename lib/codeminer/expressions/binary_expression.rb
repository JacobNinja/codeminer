class BinaryExpression < Expression

  attr_reader :left, :right

  def initialize(token, left, right, src)
    @token = token
    @left = left
    @right = right
    @src = src
  end

  def each
    [left, right]
  end

  def type
    :binary
  end

  def value
    @token.value
  end

end