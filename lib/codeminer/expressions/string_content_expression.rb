class StringContentExpression < Expression

  def add(string, src)
    if string.kind_of? StringEmbeddedExpression
      DynamicStringExpression.new(string, src)
    elsif string.kind_of? Token
      StringExpression.new(string, src)
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