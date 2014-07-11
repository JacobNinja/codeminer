module CodeMiner

  class VoidExpression < Expression

    attr_reader :value

    def initialize(src)
      @src = src
    end

    def type
      :void_stmt
    end

    def void?
      true
    end

    def each
      []
    end

  end

end