module MethodProcessor

  def on_defs(receiver, period_token, name_token, params, body)
    DefsExpression.new(receiver, name_token.value, extract_src_by_token(@keywords.pop), body)
  end

  def on_def(token, params, body)
    DefnExpression.new(token.value, params, body, extract_src_by_token(@keywords.pop))
  end

  def on_method_add_block(exp, args)
    exp.block = args
    exp
  end

  def on_method_add_arg(exp, args)
    exp.args = args
    exp
  end

  def on_brace_block(args, body)
    BlockExpression.new(body, args, extract_src_by_token(@keywords.pop))
  end

  alias_method :on_do_block, :on_brace_block

end