module AssignmentProcessor

  def on_assign(token, body)
    LocalAssignExpression.new(token, body, extract_src_by_tokens(token, body))
  end

end