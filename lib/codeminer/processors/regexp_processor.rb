module RegexpProcessor

  def on_regexp_literal(regex_strings, regex_end)
    regex = regex_strings.first
    RegexpExpression.new(regex, regex_end, extract_src(regex.line, regex.column - 1))
  end

end