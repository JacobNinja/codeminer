module CodeMiner

  module CommandProcessor

    def on_command(token, args)
      CommandExpression.new(token, args, extract_src_by_tokens(token, args))
    end

    def on_command_call(receiver, delimiter, token, args)
      CommandExpression.new(token, args, extract_src_by_tokens(receiver, args), receiver)
    end

  end

end