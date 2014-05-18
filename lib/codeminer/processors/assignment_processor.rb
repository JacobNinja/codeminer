module AssignmentProcessor

  def on_assign(token, body)
    LocalAssignExpression.new(token, body, extract_src_by_tokens(token, body))
  end

  def on_massign(params, values)
    p params, values
    MultipleAssignmentExpression.new(params, values, extract_src_by_tokens(params, values))
  end

end