module CodeMiner

  class ParamsExpression < Expression

    def self.empty
      new([], [], [], nil, nil)
    end

    attr_reader :positional, :optional, :keyword, :splat, :value

    def initialize(positional, optional, keyword, splat, block)
      @positional = positional
      @optional = optional
      @keyword = keyword
      @splat = splat
      @block = block
    end

    def type
      :params
    end

    def each
      [positional, optional, keyword, *splat, *block]
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
      [*positional.each,
       *optional.each.map(&:token), *optional.each.map(&:value),
       *keyword.each.map(&:token), *keyword.each.map(&:value),
       *splat_token,
       *block_token].select{|e| e}
    end

    def splat_token
      splat && splat.token
    end

    def block_token
      block && block.token
    end

  end

end