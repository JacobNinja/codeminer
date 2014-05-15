module ConditionProcessor

  def on_if(test, consequence, else_statement)
    ConditionExpression.new(test, consequence, else_statement, extract_src_by_token(pop_keyword))
  end

  def on_unless(test, consequence, else_statement)
    ConditionExpression.new(test, else_statement, consequence, extract_src_by_token(pop_keyword))
  end

  def on_else(consequence)
    ElseExpression.new(consequence, extract_src_by_token(pop_keyword, consequence.each.last.end_line, consequence.each.last.end_column))
  end

  def on_if_mod(test, consequence)
    pop_keyword
    ConditionExpression.new(test, consequence, nil, extract_src(consequence.line, consequence.column))
  end

  def on_unless_mod(test, else_expression)
    pop_keyword
    ConditionExpression.new(test, nil, else_expression, extract_src_by_token(else_expression))
  end

end