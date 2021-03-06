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
      ConditionExpression.new(test, consequence_body, nil, pop_keyword('if'), extract_src_by_tokens(consequence, test))
    end

    def on_unless_mod(test, else_expression)
      else_body = BodyExpression.from(else_expression)
      ConditionExpression.new(test, nil, else_body, pop_keyword('unless'), extract_src_by_tokens(else_expression, test))
    end

    def on_ifop(test, consequence, else_statement)
      ConditionExpression.new(test, BodyExpression.from(consequence), BodyExpression.from(else_statement), nil, extract_src_by_tokens(test, else_statement))
    end

    def on_case(test, whens)
      CaseExpression.new(test, extract_whens(whens), extract_src_by_token(pop_keyword('case')))
    end

    def on_when(arg, body, else_exp)
      WhenExpression.new(arg, body, else_exp, extract_src_by_tokens(pop_keyword('when'), body))
    end

    private

    def extract_whens(when_exp)
      [when_exp].tap do |whens|
        until when_exp.else.nil? || when_exp.else.type == :else
          whens << when_exp.else
          when_exp = when_exp.else
        end
      end
    end

  end

end