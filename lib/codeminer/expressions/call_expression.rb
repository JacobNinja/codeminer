class CallExpression

  attr_reader :src

  def initialize(token, src)
    @token = token
    @src = src
  end

  def type
    :call
  end

  def value
    @token.value
  end

  def line
    @token.line
  end

end