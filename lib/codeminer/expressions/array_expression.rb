class ArrayExpression < Expression

  attr_reader :value

  def initialize(items, src)
    @items = items
    @src = src
  end

  def type
    :array
  end

  def each
    Array(@items)
  end

end