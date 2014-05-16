module BinaryProcessor

  def on_binary(left, token, right)
    BinaryExpression.new(token, left, right, extract_src_by_tokens(left, right))
  end

end