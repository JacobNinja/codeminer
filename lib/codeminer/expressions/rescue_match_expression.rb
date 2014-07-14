module CodeMiner

  class RescueMatchExpression < BodyExpression

    attr_reader :value, :variable, :constants

    def initialize(constants, variable, src)
      @constants = constants
      @variable = variable
      @src = src
    end

    def type
      :rescue_body
    end

    def each
      [*@constants, @variable]
    end

  end

end