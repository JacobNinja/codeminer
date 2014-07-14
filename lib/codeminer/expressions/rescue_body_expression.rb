module CodeMiner

  class RescueBodyExpression < BodyExpression

    attr_reader :body, :value

    def self.wrap(body)
      new(body.body, body.src_extract)
    end

    def initialize(body, src)
      @body = body
      @src = src
    end

    def type
      :rescue_body
    end

  end

end