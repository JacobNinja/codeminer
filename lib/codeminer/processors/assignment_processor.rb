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
                when :field
                  AttributeAssignExpression
                when :constant
                  ConstantAssignExpression
                when :aref_field
                  ArefAssignExpression
                when :colon2
                  Colon2AssignExpression
                when :colon3
                  Colon3AssignExpression
                else
                  assert(false, "#{exp.type} is not a valid assignment")
              end
      klass.new(exp, body, extract_src_by_tokens(exp, body))
    end

    def on_massign(container, values)
      value_container = ExpressionContainer.wrap(values, :values)
      MultipleAssignmentExpression.new(container, value_container, extract_src_by_tokens(container, values))
    end

    def on_opassign(variable, op, body)
      OpAssignExpression.new(variable, op, body, extract_src_by_tokens(variable, body))
    end

  end

end