module BinaryProcessor

  def on_binary(left, token, right)
    BinaryExpression.new(token, left, right, extract_src_by_token(left, right.line, right.end_column))
  end

end