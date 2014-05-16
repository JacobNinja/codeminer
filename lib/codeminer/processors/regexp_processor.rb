module RegexpProcessor

  def on_regexp_literal(regexp, regex_end)
    regexp.tap do |r|
      r.src = extract_src_by_token(@begin_regex.pop, regex_end.line, regex_end.end_column)
    end
  end

  def on_regexp_beg(value)
    super.tap do |token|
      @begin_regex << token
    end
  end

  def on_regexp_add(regexp_content, regex)
    regexp_content.add(regex)
  end

  def on_regexp_new
    RegexpExpression.new
  end

end