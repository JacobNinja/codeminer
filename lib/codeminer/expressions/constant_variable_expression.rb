module CodeMiner

  class ConstantVariableExpression < Expression

    def initialize(token, src)
      @token = token
      @src = src
    end

    def value
      @token.value
    end

    def type
      :constant
    end

    def each
      []
    end

  end

end