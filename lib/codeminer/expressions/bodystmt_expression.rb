module CodeMiner

  class BodystmtExpression < Expression

    attr_reader :body, :rescue, :value

    def initialize(body, rescue_exp, c, d, src:)
      @body = body
      @rescue = rescue_exp
      @c, @d = c, d
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