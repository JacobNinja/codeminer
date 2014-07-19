module CodeMiner

  class BodystmtExpression < Expression

    attr_reader :body, :rescue, :ensure, :value, :else

    def initialize(body, rescue_exp, else_exp, ensure_exp, src:)
      @body = body
      @rescue = rescue_exp
      @ensure = ensure_exp
      @else = else_exp
      @src = src
    end

    def type
      :bodystmt
    end

    def each
      [*body.each, *[@rescue, @else, @ensure].compact]
    end

  end

end