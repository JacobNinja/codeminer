module CodeMiner

  module LoopProcessor

    def on_until_mod(test, body)
      pop_keyword
      UntilExpression.new(test, body, extract_src_by_token(body))
    end

    def on_until(test, body)
      UntilExpression.new(test, body, extract_src_by_token(pop_keyword))
    end

  end

end