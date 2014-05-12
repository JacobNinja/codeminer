class StringContentExpression

  def self.add(string)
    if string.kind_of? StringEmbeddedExpression
      DynamicStringExpression.new(string)
    else
      string
    end
  end

end