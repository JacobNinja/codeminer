class RetryExpression < Expression

  attr_reader :value

  def initialize(src)
    @src = src
  end

  def type
    :retry
  end

  def each
    []
  end

end