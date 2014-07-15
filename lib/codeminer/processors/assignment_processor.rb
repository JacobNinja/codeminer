module CodeMiner

  module AssignmentProcessor

    def on_assign(exp, body)
      klass = case exp
                when LocalVariableExpression
                  LocalAssignExpression
                when GlobalVariableExpression
                  GlobalVariableAssignExpression
                when InstanceVariableExpression
                  InstanceVariableAssignExpression
              end
      klass.new(exp, body, extract_src_by_tokens(exp, body))
    end

    def on_massign(params, values)
      value_container = ParamsContainer.wrap(values, :values)
      MultipleAssignmentExpression.new(params, value_container, extract_src_by_tokens(params, values))
    end

  end

end