module CodeMiner

  class SClassExpression < Expression

    attr_reader :body, :context, :value

    def initialize(context, body, src)
      @context = context
      @body = body
      @src = src
    end

    def type
      :sclass
    end

    def each
      [context, body]
    end

  end

end