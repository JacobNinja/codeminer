module CodeMiner

  class ParamsExpression < Expression

    attr_reader :positional, :optional, :value

    def initialize(positional, optional)
      @positional = positional
      @optional = optional
    end

    def type
      :params
    end

    def each
      [positional, optional]
    end

    def each_param
      each.flat_map(&:each)
    end

    def line
      expression_values.map(&:line).first
    end

    def column
      expression_values.map(&:column).first
    end

    def end_line
      expression_values.map(&:end_line).last
    end

    def end_column
      expression_values.map(&:end_column).last
    end

    private

    def expression_values
      [*positional.each, *optional.each.map(&:token), *optional.each.map(&:value)]
    end

  end

end