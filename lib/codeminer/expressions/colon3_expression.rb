module CodeMiner

  class Colon3Expression < Expression

    attr_reader :body

    def initialize(token, src)
      @token = token
      @src = src
    end

    def type
      :colon3
    end

    def value
      token.value
    end

    def each
      []
    end

  end

end