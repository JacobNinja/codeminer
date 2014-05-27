module CodeMiner

  class EmptyExpression

    def self.type
      :empty
    end

    def self.value
      nil
    end

    def self.each
      []
    end

  end

end