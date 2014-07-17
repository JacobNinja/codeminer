module CodeMiner

  class OpAssignExpression < Expression

    attr_reader :variable, :op, :body, :value

    def initialize(variable, op, body, src)
      @variable = variable
      @op = op
      @body = body
      @src = src
    end

    def type
      :op_assign
    end

    def each
      [variable, op, body]
    end

    alias receiver variable

  end

end