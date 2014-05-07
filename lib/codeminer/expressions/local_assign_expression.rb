class LocalAssignExpression < Expression

  attr_reader :receiver, :body

  def initialize(receiver, body, src)
    @receiver = receiver
    @body = body
    @src = src
  end

  def type
    :lasgn
  end

  def value
    @receiver.value
  end

end