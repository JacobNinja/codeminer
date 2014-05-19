module ParamsProcessor

  def on_params(positional, optional, *)
    ParamsExpression.new(positional_params(positional), optional_params(optional)).tap do |params|
      params.src = extract_src_by_tokens(params) if params.line
    end
  end

  def on_paren(params)
    params.src = extract_src(params.line, params.column - 1, params.end_line, params.end_column + 1) if params && params.src_extract
    params
  end

  def on_mlhs_new
    ParamsContainer.new([], :destructured_params)
  end

  def on_mrhs_new
    ParamsContainer.new([], :values)
  end

  def on_mlhs_add(params, param)
    params.add(param)
  end

  def on_mlhs_paren(exp)
    if exp.kind_of?(Token)
      DestructuredParamExpression.new(exp, exp.src_extract)
    else
      exp.src = extract_src_by_token(@parens_begin.pop)
      exp
    end
  end

  def on_mrhs_new_from_args(args)
    ParamsContainer.new(args.each, :values, args.src_extract)
  end

  def on_mrhs_add(params, exp)
    params.add(exp)
  end

  def on_mrhs_add_star(params, exp)
    params.add(SplatExpression.new(exp, extract_src(exp.line, exp.column - 1, exp.end_line, exp.end_column)))
  end

  alias :on_mlhs_add_star :on_mrhs_add_star
  
  private

  def positional_params(positional)
    positional_expressions = positional.to_a.map do |exp|
      PositionalParamExpression.convert(exp, extract_src_by_token(exp, exp.end_line, exp.end_column))
    end
    src = extract_src_by_token(positional.first, positional.last.end_line, positional.last.end_column) if positional
    ParamsContainer.new(positional_expressions, :positional, src)
  end

  def optional_params(optional)
    optional_expressions = optional.to_a.map do |token, value|
      OptionalParamExpression.new(token, value, extract_src_by_token(token, value.end_line, value.end_column))
    end
    src = extract_src_by_token(optional.first.first, optional.last.last.end_line, optional.last.last.end_column) if optional
    ParamsContainer.new(optional_expressions, :optional, src)
  end

end