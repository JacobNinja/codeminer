module ParamsProcessor

  def on_params(positional, optional, *)
    ParamsExpression.new(positional_params(positional), optional_params(optional)).tap do |params|
      token = params.each.map(&:token).first
      params.src = extract_src_by_token(token) if token
    end
  end

  def on_paren(params)
    params.src = extract_src(params.line, params.column - 1, params.end_line, params.end_column + 1) if params
    params
  end
  
  private

  def positional_params(positional)
    positional_expressions = positional.to_a.map do |token|
      PositionalParamExpression.new(token, extract_src_by_token(token))
    end
    src = extract_src_by_token(positional.first, positional.last.end_line, positional.last.end_column) if positional
    ParamsContainer.new(positional_expressions, src)
  end

  def optional_params(optional)
    optional_expressions = optional.to_a.map do |token, value|
      OptionalParamExpression.new(token, value, extract_src_by_token(token, value.end_line, value.end_column))
    end
    src = extract_src_by_token(optional.first.first, optional.last.last.end_line, optional.last.last.end_column) if optional
    ParamsContainer.new(optional_expressions, src)
  end

end