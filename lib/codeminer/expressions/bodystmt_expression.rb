class BodystmtExpression

  def initialize(a, b, c, d)
    @a, @b, @c, @d = a, b, c, d
  end

  def type
    :bodystmt
  end

  def children
    @a.to_a.first == VoidExpression ? [] : @a
  end

end