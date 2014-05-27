module CodeMiner

  class RedoExpression < Expression

    attr_reader :value

    def initialize(src)
      @src = src
    end

    def type
      :redo
    end

    def each
      []
    end

  end

end