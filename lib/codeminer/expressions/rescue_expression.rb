module CodeMiner

  class RescueExpression < Expression

    attr_reader :body, :value, :match

    def initialize(match, body, d, src)
      @match = match
      @body = body
      @d = d
      @src = src
    end

    def type
      :rescue
    end

    def each
      [match, *body.each]
    end

  end

end