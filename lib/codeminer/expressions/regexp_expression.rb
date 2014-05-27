module CodeMiner

  class RegexpExpression < Expression

    def initialize
      @content = []
    end

    def type
      :regexp
    end

    def value
      src
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