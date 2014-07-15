module CodeMiner

  module AssignmentProcessor

    def on_assign(exp, body)
      klass = case exp.type
                when :local_variable
                  LocalAssignExpression
                when :global_variable
                  GlobalVariableAssignExpression
                when :instance_variable
                  InstanceVariableAssignExpression
                when :class_variable
                  ClassVariableAssignExpression
              end
      klass.new(exp, body, extract_src_by_tokens(exp, body))
    end

    def on_massign(params, values)
      value_container = ParamsContainer.wrap(values, :values)
      MultipleAssignmentExpression.new(params, value_container, extract_src_by_tokens(params, values))
    end

  end

end