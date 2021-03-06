module CodeMiner

  module ReturnProcessor

    def on_return(body)
      ReturnExpression.new(body, extract_src_by_token(pop_keyword('return')))
    end

    def on_return0
      ReturnExpression.new(nil, extract_src_by_token(pop_keyword('return')))
    end

  end

end