module CodeMiner

  class InstanceVariableExpression < Expression

    attr_reader :value

    def initialize(value, src)
      @value = value
      @src = src
    end

    def type
      :instance_variable
    end

    def each
      []
    end

  end

end