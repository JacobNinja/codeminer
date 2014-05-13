module StringProcessor

  def on_tstring_beg(value)
    @string_begin = Token.new(:tstring_beg, value, lineno(), column())
  end

  def on_embexpr_beg(value)
    @embexpr_begin = Token.new(:embexpr_beg, value, lineno(), column())
  end

  def on_tstring_content(value)
    StringExpression.new(Token.new(:tstring_content, value, lineno(), column()), value)
  end

  def on_string_add(string_content, string)
    string_content.add(string)
  end

  def on_string_content
    StringContentExpression.new
  end

  def on_string_embexpr(body)
    body.each.last.delimiter = '}'
    embedded_expression_src = extract_src_by_token(@embexpr_begin)
    @embexpr_begin = nil
    StringEmbeddedExpression.new(body, embedded_expression_src)
  end

  def on_string_literal(string_content)
    string_content.tap do |string|
      string.src = extract_src_by_token(@string_begin)
      @string_begin = nil
    end
  end

end