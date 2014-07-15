module CodeMiner

  class ClassVariableAssignExpression < Expression

    attr_reader :body

    def initialize(token, body, src)
      @token = token
      @body = body
      @src = src
    end

    def type
      :class_variable_assign
    end

    def value
      @token.value
    end

    def each
      [@body]
    end

  end

end