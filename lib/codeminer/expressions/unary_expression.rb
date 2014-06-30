module CodeMiner

  class UnaryExpression < Expression

    attr_reader :value, :receiver

    def initialize(value, receiver, src)
      @value = value
      @receiver = receiver
      @src = src
    end

    def type
      :unary
    end

    def each
      [@receiver]
    end

  end

end