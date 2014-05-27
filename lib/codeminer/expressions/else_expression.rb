class ElseExpression < Expression

  attr_reader :value, :consequence

  def initialize(consequence, src)
    @consequence = consequence
    @src = src
  end

  def type
    :else
  end

  def body
    consequence
  end

  def each
    [consequence]
  end

end