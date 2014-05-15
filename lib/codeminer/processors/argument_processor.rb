module ArgumentProcessor

  def on_args_new
    ArgumentsExpression.new
  end

  def on_args_add_block(exp, block)
    exp.block = block
    exp
  end

  def on_args_add(args, exp)
    args.add(exp)
  end

end