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
    string_content.add(string, extract_src_by_token(string_content), string.line, string.column)
  end

  def on_string_content
    StringContentExpression.new(lineno(), column())
  end

  def on_string_embexpr(body)
    body.last.src.chomp!('}')
    StringEmbeddedExpression.new(body, extract_src_by_token(@embexpr_begin), lineno(), column())
  end

  def on_string_literal(string)
    src_with_quotes = extract_src_by_token(@string_begin)
    @string_begin = nil
    string.add_quotes(src_with_quotes)
  end

end