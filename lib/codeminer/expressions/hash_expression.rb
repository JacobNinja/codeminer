class HashExpression < Expression

  def initialize(pairs, src)
    @pairs = pairs
    @src = src
  end

  def type
    :hash
  end

  def each
    @pairs
  end

end