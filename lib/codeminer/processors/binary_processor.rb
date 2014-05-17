module BinaryProcessor

  def on_binary(left, value, right)
    token = Token.new(:op, value.to_s, extract_src_by_value(value))
    BinaryExpression.new(token, left, right, extract_src_by_tokens(left, right))
  end

end