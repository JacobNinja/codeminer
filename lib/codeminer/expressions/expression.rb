module CodeMiner

  class Expression

    include SourceExtract::Usage

    attr_writer :src

    def self.not_implemented(*attrs)
      attrs.each do |attr|
        define_method attr do |*|
          raise NotImplementedError, "Need to define #{attr} on #{self.class}"
        end
      end
    end

    def to_a
      [self]
    end

    def void?
      false
    end

    attr_accessor :block, :args, :delimiter
    attr_reader :token

    not_implemented :<<, :each, :type, :value

  end

end
