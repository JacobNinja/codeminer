class LocalAssignExpression < Expression

  attr_reader :receiver, :body

  def initialize(receiver, body, src)
    @receiver = receiver
    @body = body
    @src = src
  end

  def type
    :assign
  end

  def value
    @receiver.value
  end

  def line
    @receiver.line
  end

  def column
    @receiver.column
  end

  def each
    [body]
  end

end