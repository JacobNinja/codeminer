module AssignmentProcessor

  def on_assign(token, body)
    LocalAssignExpression.new(token, body, extract_src_by_tokens(token, body))
  end

  def on_massign(params, values)
    value_container = ParamsContainer.wrap(values, :values)
    MultipleAssignmentExpression.new(params, value_container, extract_src_by_tokens(params, values))
  end

end