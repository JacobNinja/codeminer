module CodeMiner

  module ConditionProcessor

    def on_if(test, consequence, else_statement)
      token = pop_keyword('if')
      ConditionExpression.new(test, consequence, else_statement, token, extract_src_by_token(token))
    end

    def on_elsif(test, consequence, else_statement)
      token = pop_keyword('elsif')
      ConditionExpression.new(test, consequence, else_statement, token, extract_src_by_token(token))
    end

    def on_unless(test, consequence, else_statement)
      token = pop_keyword('unless')
      ConditionExpression.new(test, else_statement, consequence, token, extract_src_by_token(token))
    end

    def on_else(body)
      ElseExpression.new(body, extract_src_by_tokens(pop_keyword('else'), body))
    end

    def on_if_mod(test, consequence)
      consequence_body = BodyExpression.from(consequence)
      ConditionExpression.new(test, consequence_body, nil, pop_keyword('if'), extract_src(consequence.line, consequence.column))
    end

    def on_unless_mod(test, else_expression)
      else_body = BodyExpression.from(else_expression)
      ConditionExpression.new(test, nil, else_body, pop_keyword('unless'), extract_src_by_token(else_expression))
    end

    def on_ifop(test, consequence, else_statement)
      ConditionExpression.new(test, consequence, else_statement, nil, extract_src_by_tokens(test, else_statement))
    end

    def on_case(test, whens)
      whens_array = whens.class == Array ? whens : [whens]
      CaseExpression.new(test, whens_array, extract_src_by_token(pop_keyword('case')))
    end

    def on_when(arg, body, else_exp)
      WhenExpression.new(arg, body, else_exp, extract_src_by_tokens(pop_keyword('when'), body))
    end

  end

end