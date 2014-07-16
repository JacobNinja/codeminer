module CodeMiner

  class SplatExpression < Expression

    def initialize(token, src)
      @token = token
      @src = src
    end

    def type
      :splat
    end

    def value
      @token.value
    end

    def each
      @token.each
    end

  end

end