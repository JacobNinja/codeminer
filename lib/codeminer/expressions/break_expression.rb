module CodeMiner

  class BreakExpression < Expression

    attr_reader :value

    def initialize(args, src)
      @args = args
      @src = src
    end

    def type
      :break
    end

    def each
      [@args]
    end

  end

end