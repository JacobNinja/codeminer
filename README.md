Codeminer
=========
Parse Ruby code into indexable expressions

Parser
===
Codeminer takes advantage of [Ripper](http://ruby-doc.org/stdlib-2.1.2/libdoc/ripper/rdoc/Ripper.html) and produces a custom abstract syntax tree.
Each syntax node has accurate source information and contains references to its immediate children.

Processor
===
A processor is a stateful object that hooks into the codeminer parser and subscribes to parse events. 

Example:
```ruby
class ClassNameProcessor

  def initialize
    @class_names = []
  end
  
  # Hook into the "class" parse event
  def process_class(exp)
    @class_names << exp.value
  end
  
  def result
    @class_names
  end
  
end
```

The processor shown above can be invoked in the following way:
```ruby
class_name_processor = ClassNameProcessor.new
CodeMiner.process('class Bar; end; class Foo; end', [class_name_processor])
class_name_processor.result # => ['Bar', 'Foo']
```
