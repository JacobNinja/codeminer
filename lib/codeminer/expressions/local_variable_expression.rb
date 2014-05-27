module CodeMiner

  class LocalVariableExpression < Expression

    def initialize(token, src)
      @token = token
      @src = src
    end

    def type
      :local_variable
    end

    def value
      @token.value
    end

    def each
      []
    end

  end

end