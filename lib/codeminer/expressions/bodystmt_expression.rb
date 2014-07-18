module CodeMiner

  class BodystmtExpression < Expression

    attr_reader :body, :rescue, :ensure, :value

    def initialize(body, rescue_exp, c, ensure_exp, src:)
      @body = body
      @rescue = rescue_exp
      @ensure = ensure_exp
      @c = c
      @src = src
    end

    def type
      :bodystmt
    end

    def each
      if @rescue
        [*body.each, @rescue]
      else
        @body.each
      end
    end

  end

end