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
      @keywords << token if %w(do class def).include?(kw)
    end
  end

end