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
    if args
      exp.args = args
      exp.adjust_src(extract_src_by_tokens(exp, args))
    end
    exp
  end

  def on_arg_paren(args)
    args ||= ArgumentsExpression.new(lineno(), column())
    args.src = extract_src_by_token(@parens_begin.pop)
    args
  end

  def on_brace_block(args, body)
    BlockExpression.new(body, args, extract_src_by_token(pop_keyword))
  end

  alias_method :on_do_block, :on_brace_block

end