VoidExpression = Object.new

class Expression

  attr_writer :src
  attr_reader :token

  def self.not_implemented(*attrs)
    attrs.each do |attr|
      define_method attr do |*|
        raise NotImplementedError, "Need to define #{attr} on #{self.class}"
      end
    end
  end

  def src
    if delimiter
      extracted_source.chomp(delimiter.to_s)
    else
      extracted_source
    end
  end

  def line
    @src.line
  end

  def column
    @src.column
  end

  def end_line
    @src.end_line
  end

  def end_column
    @src.end_column
  end

  def extracted_source
    if @src.respond_to?(:extract)
      @src.extract
    else
      @src
    end
  end

  attr_accessor :block, :args, :delimiter

  not_implemented :<<, :each, :type, :value

end
