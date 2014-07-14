module CodeMiner

  module VariableProcessor

    def on_var_ref(exp)
      if exp.kind_of?(Token)
        case exp.type
          when :const
            ConstantVariableExpression.new(exp, exp.src_extract)
          else
            LocalVariableExpression.new(exp, exp.src_extract)
        end
      else
        exp
      end
    end

    def on_var_field(token)
      LocalVariableExpression.new(token, extract_src_by_tokens(token))
    end

    def on_gvar(value)
      GlobalVariableExpression.new(value, extract_src_by_value(value))
    end

    def on_ivar(value)
      InstanceVariableExpression.new(value, extract_src_by_value(value))
    end

    def on_cvar(value)
      ClassVariableExpression.new(value, extract_src_by_value(value))
    end

    def on_backref(value)
      BackrefVariableExpression.new(value.slice(1..-1), extract_src_by_value(value))
    end

  end

end