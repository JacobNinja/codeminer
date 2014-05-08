VoidExpression = Object.new

class Expression

  def self.not_implemented(*attrs)
    attrs.each do |attr|
      define_method attr do |*|
        raise NotImplementedError, "Need to define #{attr} on #{self.class}"
      end
    end
  end

  attr_reader :src
  attr_accessor :block, :args, :delimiter

  not_implemented :line, :column, :end_column, :<<, :each, :type, :value

end
