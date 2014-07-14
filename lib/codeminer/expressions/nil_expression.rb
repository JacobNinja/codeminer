module CodeMiner

  class NilExpression < Expression

    def initialize(token, src)
      @token = token
      @src = src
    end

    def type
      :nil
    end

    def value
      @token.value
    end

    def each
      []
    end

  end

end