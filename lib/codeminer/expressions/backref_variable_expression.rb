module CodeMiner

  class BackrefVariableExpression < Expression

    attr_reader :value

    def initialize(value, src)
      @value = value
      @src = src
    end

    def type
      :backref_variable
    end

    def each
      []
    end

  end

end