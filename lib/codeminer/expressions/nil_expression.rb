module CodeMiner

  class NilExpression < Expression

    attr_reader :value

    def initialize(token, src)
      @token = token
      @src = src
    end

    def type
      :nil
    end

    def each
      []
    end

  end

end