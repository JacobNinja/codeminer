class BlockExpression < Expression

  attr_reader :body

  def initialize(body, args, src)
    @body = body
    @args = args
    @src = src
  end

  def type
    :block
  end

  def each
    Array(@body)
  end

end
