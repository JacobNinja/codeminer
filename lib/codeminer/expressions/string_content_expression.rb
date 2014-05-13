class StringContentExpression < Expression

  def add(string)
    if string.kind_of? StringEmbeddedExpression
      DynamicStringExpression.new(string)
    else
      string
    end
  end

  def type
    :string
  end

  def value
    ''
  end

  def each
    []
  end

end