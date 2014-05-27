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

    #def body
    #  if @rescue
    #    @rescue.wrap(@body)
    #  else
    #    @body
    #  end
    #end

    def each
      #[body, @c, @d].compact
      @body.each.first.kind_of?(VoidExpression) ? [] : @body.each
    end

  end

end