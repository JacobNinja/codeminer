module ArgumentProcessor

  def on_args_add_block(exp, block)
    exp.block = block
    exp
  end

  def on_args_add(args, exp)
    exp.args = args
    exp
  end

end