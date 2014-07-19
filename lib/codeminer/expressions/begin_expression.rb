module CodeMiner

  class BeginExpression < Expression

    attr_reader :bodystmt, :value

    def initialize(bodystmt, src)
      @bodystmt = bodystmt
      @src = src
    end

    def type
      :begin
    end

    def body
      @bodystmt.body
    end

    def ensure
      @bodystmt.ensure
    end

    def rescue
      @bodystmt.rescue
    end

    def else
      @bodystmt.else
    end

    def each
      body.each
    end

  end

end