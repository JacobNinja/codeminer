module CodeMiner

  class BlockParamExpression < Expression

    def initialize(token, src)
      @token = token
      @src = src
    end

    def type
      :block_param
    end

    def value
      @token.value
    end

    def each
      []
    end

  end

end