module CodeMiner

  class GlobalVariableExpression < Expression

    attr_reader :value

    def initialize(value, src)
      @value = value
      @src = src
    end

    def type
      :global_variable
    end

    def each
      []
    end

  end

end