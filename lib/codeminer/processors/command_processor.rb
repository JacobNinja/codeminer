module CodeMiner

  module CommandProcessor

    def on_command(token, args)
      CommandExpression.new(token, args, extract_src_by_token(token))
    end

    def on_command_call(receiver, delimiter, token, args)
      CommandExpression.new(token, args, extract_src_by_token(receiver), receiver)
    end

  end

end