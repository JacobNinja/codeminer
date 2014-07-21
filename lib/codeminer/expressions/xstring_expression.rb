module CodeMiner

  class XStringExpression < Expression

    def initialize(token, src)
      @token = token
      @src = src
    end

    def value
      @token.value
    end

    def type
      :xstring
    end

    def each
      @token.each
    end

  end

end