class BodystmtExpression < Expression

  def initialize(a, b, c, d)
    @a, @b, @c, @d = a, b, c, d
  end

  def type
    :bodystmt
  end

  def each
    @a.to_a.first == VoidExpression ? [] : @a
  end

end