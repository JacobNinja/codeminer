module ArrayProcessor

  def on_array(args)
    ArrayExpression.new(args, extract_src_from_args(args))
  end

  def on_qwords_new
    ArgumentsExpression.new(SourceExtract::Partial.new(@src, lineno(), column()), @qwords.pop)
  end

  def on_qwords_add(args, str)
    args.add(str)
  end

  def on_qsymbols_new
    ArgumentsExpression.new(SourceExtract::Partial.new(@src, lineno(), column()), @qsymbols.pop)
  end

  def on_qsymbols_add(args, string)
    args.add(SymbolExpression.convert(string))
  end

  def on_symbols_new
    ArgumentsExpression.new(SourceExtract::Partial.new(@src, lineno(), column()), @symbols.pop)
  end

  def on_symbols_add(args, string)
    args.add(SymbolExpression.convert(string))
  end

  def on_word_add(words, word)
    word
  end

  def on_word_new

  end

  def on_words_add(words, word)
    words.add(StringExpression.convert(word))
  end

  def on_words_new
    ArgumentsExpression.new(SourceExtract::Partial.new(@src, lineno(), column()), @words.pop)
  end

  def on_qwords_beg(*)
    super.tap do |token|
      @qwords << token
    end
  end

  def on_qsymbols_beg(*)
    super.tap do |token|
      @qsymbols << token
    end
  end

  def on_symbols_beg(*)
    super.tap do |token|
      @symbols << token
    end
  end

  def on_words_beg(*)
    super.tap do |token|
      @words << token
    end
  end

  private

  def extract_src_from_args(args)
    if args
      size = args.token ? args.token.value.length : 1
      extract_src(args.line, args.column - size)
    else
      extract_src(lineno(), column() - 2)
    end
  end

end