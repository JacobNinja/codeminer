module CodeMiner

  module ClassProcessor

    def on_class(token, parent, body)
      ClassExpression.new(token, parent, body, extract_src_by_token(pop_keyword))
    end

    def on_sclass(context, body)
      SClassExpression.new(context, body, extract_src_by_token(pop_keyword))
    end

    def on_module(token, body)
      ModuleExpression.new(token, body, extract_src_by_token(pop_keyword))
    end

  end

end