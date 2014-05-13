class BodystmtExpression < Expression

  def initialize(a, b, c, d)
    @a, @b, @c, @d = a, b, c, d
  end

  def type
    :bodystmt
  end

  def each
    @a.each.first == VoidExpression ? [] : @a.each
  end

end