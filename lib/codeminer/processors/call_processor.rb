module CallProcessor

  def on_vcall(token)
    CallExpression.new(token, extract_src_by_token(token))
  end

  def on_call(receiver, delimiter, token)
    puts receiver, token, receiver.class
    receiver.delimiter = delimiter
    CallExpression.new(token, extract_src_by_token(receiver), receiver: receiver)
  end

  def on_fcall(token)
    CallExpression.new(token, extract_src_by_token(token))
  end

  def on_params(positional, b, c, d, e, f, g)
    src = positional ? extract_params_source(positional) : nil
    ParamsExpression.new(src, positional)
  end

end