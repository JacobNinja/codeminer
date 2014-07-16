module CodeMiner

  module VariableProcessor

    def on_var_ref(exp)
      if exp.kind_of?(Token)
        cast_variable_to_type(exp)
      else
        exp
      end
    end

    alias on_var_field on_var_ref

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

    def on_field(receiver, delimiter, token)
      FieldExpression.new(receiver, token, extract_src_by_tokens(receiver, token))
    end

    def on_const_path_ref(const, token)
      Colon2Expression.new(token, const, extract_src_by_tokens(const, token))
    end

    private

    def cast_variable_to_type(exp)
      if exp.type == :const
        ConstantVariableExpression.new(exp, exp.src_extract)
      elsif exp.value == 'nil'
        token = pop_keyword
        NilExpression.new(token, extract_src_by_tokens(token, token))
      else
        LocalVariableExpression.new(exp, exp.src_extract)
      end
    end

  end

end