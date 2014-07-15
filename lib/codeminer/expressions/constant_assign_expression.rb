module CodeMiner

  class ConstantAssignExpression < Expression

    attr_reader :body

    def initialize(token, body, src)
      @token = token
      @body = body
      @src = src
    end

    def type
      :constant_assign
    end

    def value
      @token.value
    end

    def each
      [@body]
    end

  end

end