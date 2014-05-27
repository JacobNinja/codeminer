module CodeMiner

  class VariableExpression < Expression

    def initialize(token, src)
      @token = token
      @src = src
    end

    def type
      :var_ref
    end

    def each
      [@token]
    end

  end

end