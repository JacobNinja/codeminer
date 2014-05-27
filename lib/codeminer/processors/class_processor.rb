module CodeMiner

  module ClassProcessor

    def on_class(token, parent, body)
      ClassExpression.new(token.value, body, extract_src_by_token(pop_keyword))
    end

  end

end