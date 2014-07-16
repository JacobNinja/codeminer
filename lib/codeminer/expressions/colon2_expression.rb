module CodeMiner

  class Colon2Expression < Expression

    attr_reader :body

    def initialize(token, body, src)
      @token = token
      @body = body
      @src = src
    end

    def type
      :colon2
    end

    def value
      token.value
    end

    def each
      [body]
    end

  end

end