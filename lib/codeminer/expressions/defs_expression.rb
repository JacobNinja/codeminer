class DefsExpression

  attr_reader :src, :body

  def initialize(receiver, name, src, body)
    @receiver_token = receiver
    @name = name
    @src = src
    @body = body
  end

  def receiver
    @receiver_token.value
  end

  def value
    @name
  end

  def type
    :defs
  end

  def line
    @receiver_token.line
  end

end