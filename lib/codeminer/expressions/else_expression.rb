class ElseExpression < Expression

  def initialize(consequence, src)
    @consequence = consequence
    @src = src
  end

  def type
    :else
  end

  def body
    @consequence
  end

end