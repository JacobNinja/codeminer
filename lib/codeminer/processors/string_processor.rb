module StringProcessor

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
    embedded_expression_src = extract_src_by_token(@embexpr.pop)
    StringEmbeddedExpression.new(body, embedded_expression_src)
  end

  def on_string_literal(string_content)
    string_content.tap do |string|
      string.src = extract_src_by_tokens(@string_begin.pop, @string_end.pop)
    end
  end

  def on_tstring_beg(value)
    Token.new(:tstring_beg, value, lineno(), column()).tap do |token|
      @string_begin << token
    end
  end

  def on_tstring_end(value)
    Token.new(:tstring_end, value, lineno(), column()).tap do |token|
      @string_end << token
    end
  end

  def on_embexpr_beg(value)
    Token.new(:embexpr_beg, value, lineno(), column()).tap do |token|
      @embexpr << token
    end
  end

  def on_heredoc_beg(value)
    Token.new(:heredoc_beg, value, lineno(), column()).tap do |token|
      @string_begin << token
    end
  end

  def on_heredoc_end(value)
    Token.new(:heredoc_end, value, lineno(), column()).tap do |token|
      @string_end << token
    end
  end

end