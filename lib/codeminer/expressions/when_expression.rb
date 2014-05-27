module CodeMiner

  class WhenExpression < Expression

    attr_reader :value, :else, :body

    def initialize(args, body, else_exp, src)
      @args = args
      @body = body
      @else = else_exp
      @src = src
    end

    def type
      :when
    end

    def each
      [@args, @body]
    end

  end

end