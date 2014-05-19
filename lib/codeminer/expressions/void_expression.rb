class VoidExpression < Expression

  attr_reader :value

  def initialize(src)
    @src = src
  end

  def type
    :void_stmt
  end

  def each
    []
  end

end