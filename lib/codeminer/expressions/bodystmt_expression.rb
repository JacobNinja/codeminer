class BodystmtExpression < Expression

  attr_reader :value

  def initialize(a, b, c, d, src:)
    @a, @b, @c, @d = a, b, c, d
    @src = src
  end

  def type
    :bodystmt
  end

  def each
    @a.each.first.kind_of?(VoidExpression) ? [] : @a.each
  end

end