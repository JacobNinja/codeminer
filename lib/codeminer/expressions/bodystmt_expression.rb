class BodystmtExpression

  def initialize(a, b, c, d)
    @a, @b, @c, @d = a, b, c, d
  end

  def type
    :bodystmt
  end

  def children
    @a[2]
  end

end