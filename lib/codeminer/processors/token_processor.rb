module TokenProcessor

  def self.tokens(*attrs)
    attrs.each do |attr|
      define_method :"on_#{attr}" do |token|
        token
      end
    end
  end

  tokens :const_ref, :var_field

  def on_var_ref(token)
    VariableExpression.new(token, extract_src_by_token(token))
  end

  def on_lbrace(token)
    @keywords << super
    token
  end

  def on_kw(kw)
    super.tap do |token|
      if %w(do class def if else unless return alias).include?(kw.gsub(/[^a-z]/, ''))
        @keywords << token
      end
    end
  end

end