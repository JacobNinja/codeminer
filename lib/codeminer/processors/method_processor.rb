module MethodProcessor

  def on_defs(receiver, period_token, name_token, params, body)
    DefsExpression.new(receiver, name_token.value, extract_src_by_token(pop_keyword), body)
  end

  def on_def(token, params, body)
    DefnExpression.new(token.value, params, body, extract_src_by_token(pop_keyword))
  end

  def on_method_add_block(exp, args)
    exp.block = args
    exp
  end

  def on_method_add_arg(exp, args)
    exp.args = args
    exp.src = extract_src_by_tokens(exp, args) if args
    exp
  end

  def on_arg_paren(args)
    args.src = extract_src_by_token(@parens_begin.pop) if args
    args || ArgumentsExpression.new(lineno(), column())
  end

  def on_brace_block(args, body)
    BlockExpression.new(body, args, extract_src_by_token(pop_keyword))
  end

  alias_method :on_do_block, :on_brace_block

end