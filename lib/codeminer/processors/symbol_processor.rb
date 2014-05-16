module SymbolProcessor

  def on_symbol_literal(symbol)
    symbol.src = extract_src_by_tokens(@symbol_begin.pop, symbol)
    symbol
  end

  def on_symbol(token)
    SymbolExpression.new(token, extract_src_by_token(token))
  end

  def on_dyna_symbol(*body)
    body.first.src = extract_src_by_tokens(@string_begin.pop, @string_end.pop)
    DynamicSymbolExpression.new(*body, extract_src_by_tokens(@symbol_begin.pop, body.last))
  end

  def on_symbeg(value)
    super.tap do |token|
      if value.end_with?('"', "'")
        @symbol_begin << Token.new(:symbeg, value.chomp('"').chomp("'"), extract_src_by_token(token, token.end_line, token.end_column - 1))
        @string_begin << Token.new(:tstring_beg, value.slice(1..-1), extract_src(token.line, token.column + 1, token.end_line, token.end_column - 1))
      else
        @symbol_begin << token
      end
    end
  end

end