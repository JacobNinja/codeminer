module CodeMiner

  class BlockExpression < Expression

    attr_reader :body, :params, :value

    def initialize(body, params, src)
      @body = body
      @params = params
      @src = src
    end

    def type
      :block
    end

    def each
      [@params, *Array(@body.each)]
    end

  end


end