module AssignmentProcessor

  def on_assign(token, body)
    LocalAssignExpression.new(token, body, extract_src_by_token(token, body.line, body.end_column))
  end

end