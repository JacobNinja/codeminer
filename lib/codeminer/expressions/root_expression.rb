module CodeMiner

  class RootExpression < Expression

    attr_reader :src, :value

    def initialize(body, src)
      @body = body
      @src = src
    end

    def each
      @body.each
    end

    def type
      :root
    end

  end

end