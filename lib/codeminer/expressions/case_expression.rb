module CodeMiner

  class CaseExpression < Expression

    attr_reader :value

    def initialize(test, whens, src)
      @test = test
      @whens = whens
      @src = src
    end

    def type
      :case
    end

    def else_exp
      Array(@whens).map(&:else).last
    end

    def each
      [@test, @whens, else_exp].compact
    end

  end

end