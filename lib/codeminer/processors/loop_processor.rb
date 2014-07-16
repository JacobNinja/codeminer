module CodeMiner

  module LoopProcessor

    def on_until_mod(test, body)
      pop_keyword('until')
      UntilExpression.new(test, body, extract_src_by_token(body))
    end

    def on_until(test, body)
      UntilExpression.new(test, body, extract_src_by_token(pop_keyword('until')))
    end

    def on_while(test, body)
      WhileExpression.new(test, body, extract_src_by_token(pop_keyword('while')))
    end

    def on_while_mod(test, body)
      pop_keyword('while')
      WhileExpression.new(test, body, extract_src_by_token(body))
    end

    def on_for(params, receiver, body)
      params_container = ParamsContainer.wrap(params, :positional)
      ForExpression.new(params_container, receiver, body, extract_src_by_token(pop_keyword('for')))
    end

  end

end