module CodeMiner

  class RescueExpression < Expression

    attr_reader :body, :value, :constants, :variable

    def initialize(constants, variable, body, d, src)
      @constants = constants
      @variable = variable
      @body = body
      @d = d
      @src = src
    end

    def type
      :rescue
    end

    def each
      [constants, variable, *body.each]
    end

  end

end