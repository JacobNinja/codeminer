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

  attr_accessor :block, :args, :delimiter

  not_implemented :<<, :each, :type, :value

end
