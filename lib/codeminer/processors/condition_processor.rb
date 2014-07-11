module CodeMiner

  module ConditionProcessor

    def on_if(test, consequence, else_statement)
      token = pop_keyword
      ConditionExpression.new(test, consequence, else_statement, token, extract_src_by_token(token))
    end

    alias on_elsif on_if

    def on_unless(test, consequence, else_statement)
      token = pop_keyword
      ConditionExpression.new(test, else_statement, consequence, token, extract_src_by_token(token))
    end

    def on_else(body)
      ElseExpression.new(body, extract_src_by_token(pop_keyword, body.end_line, body.end_column))
    end

    def on_if_mod(test, consequence)
      ConditionExpression.new(test, consequence, nil, pop_keyword, extract_src(consequence.line, consequence.column))
    end

    def on_unless_mod(test, else_expression)
      ConditionExpression.new(test, nil, else_expression, pop_keyword, extract_src_by_token(else_expression))
    end

    def on_ifop(test, consequence, else_statement)
      ConditionExpression.new(test, consequence, else_statement, nil, extract_src_by_tokens(test, else_statement))
    end

    def on_case(test, whens)
      CaseExpression.new(test, whens, extract_src_by_token(pop_keyword))
    end

    def on_when(arg, body, else_exp)
      WhenExpression.new(arg, body, else_exp, extract_src_by_token(pop_keyword, body.end_line, body.end_column))
    end

  end

end