module CodeMiner

  module HashProcessor

    def on_hash(pairs)
      HashExpression.new(pairs.to_a, extract_src_by_token(pop_keyword))
    end

    def on_bare_assoc_hash(pairs)
      HashExpression.new(pairs.to_a, extract_src_by_tokens(pairs.first, pairs.last))
    end

    def on_assoclist_from_args(pairs)
      pairs
    end

    def on_assoc_new(key, value)
      HashPairExpression.new(key, value, extract_src_by_token(key, value.end_line, value.end_column))
    end

    def on_label(value)
      Token.new(:symbol, value.chomp(':'), extract_src_by_value(value))
    end

  end

end