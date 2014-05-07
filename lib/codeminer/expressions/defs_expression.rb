class DefsExpression < Expression

  attr_reader :body

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

  def each
    @body.each
  end

end