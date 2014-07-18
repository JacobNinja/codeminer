module CodeMiner

  class RegexpExpression < Expression

    attr_reader :value

    def initialize
      @content = []
    end

    def type
      :regexp
    end

    def each
      @content
    end

    def add(regex)
      @content << regex
      self
    end

  end

end