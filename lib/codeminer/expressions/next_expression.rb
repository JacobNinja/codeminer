module CodeMiner

  class NextExpression < Expression

    attr_reader :value

    def initialize(args, src)
      @args = args
      @src = src
    end

    def type
      :next
    end

    def each
      [@args]
    end

  end

end