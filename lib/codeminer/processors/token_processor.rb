module TokenProcessor

  def self.tokens(*attrs)
    attrs.each do |attr|
      define_method :"on_#{attr}" do |token|
        token
      end
    end
  end

  tokens :var_ref, :const_ref, :var_field

  def on_lbrace(token)
    @keywords << Token.new('{', nil, lineno(), column())
    token
  end

  def on_kw(kw)
    Token.new(:kw, kw, lineno(), column()).tap do |token|
      if %w(do class def if else unless return).include?(kw.gsub(/[^a-z]/, ''))
        @keywords << token
      end
    end
  end

end