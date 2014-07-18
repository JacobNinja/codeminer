module CodeMiner

  class SuperExpression < Expression

    attr_reader :value, :body

    def initialize(body, src)
      @body = body
      @src = src
    end

    def type
      :super
    end

    def each
      if body
        body.each
      else
        []
      end
    end

  end

end