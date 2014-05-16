module CallProcessor

  def on_vcall(token)
    CallExpression.new(token, extract_src_by_token(token, token.line, token.end_column))
  end

  def on_call(receiver, delimiter, token)
    receiver.delimiter = delimiter
    CallExpression.new(token, extract_src_by_tokens(receiver, token), receiver: receiver)
  end

  def on_fcall(token)
    CallExpression.new(token, extract_src_by_token(token))
  end

  def on_aref(receiver, args)
    args.src = extract_src(@lbracket.line, @lbracket.column + 1, lineno(), column() - 1)
    CallExpression.new(@lbracket, extract_src_by_token(receiver), receiver: receiver, arguments: args)
  end

  def on_lbracket(value)
    @lbracket = super
  end

end