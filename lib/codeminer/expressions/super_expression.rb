module CodeMiner

  class SuperExpression < Expression

    attr_reader :value

    def initialize(src)
      @src = src
    end

    def type
      :super
    end

    def each
      []
    end

  end

end