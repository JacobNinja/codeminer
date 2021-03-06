module CodeMiner

  module ArgumentProcessor

    def on_args_new
      ArgumentsExpression.new(SourceExtract::Partial.new(@src, lineno(), column()))
    end

    def on_args_add_block(exp, block)
      exp.block = block
      exp
    end

    def on_args_add(args, exp)
      args.adjust_src(exp.src_extract)
      args.add(exp)
    end

    def on_args_add_star(args, exp)
      args.add(SplatExpression.new(exp, extract_src(exp.line, exp.column - 1, exp.end_line, exp.end_column)))
    end

  end

end