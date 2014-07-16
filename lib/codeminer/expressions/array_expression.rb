module CodeMiner

  class ArrayExpression < Expression

    attr_reader :value

    def initialize(args, src)
      @args = args
      @src = src
    end

    def type
      :array
    end

    def each
      Array(args)
    end

  end

end