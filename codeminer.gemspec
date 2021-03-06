Gem::Specification.new do |s|
  s.name = 'codeminer'
  s.version = '0.2'
  s.date = '2014-06-30'

  s.summary = 'Mines Ruby code'
  s.description = 'Streamlined parsing and processing of Ruby code using Ripper'

  s.authors = ['Jacob Richardson']
  s.email = 'jacob.ninja.dev@gmail.com'

  s.require_paths = %w[lib]

  s.add_development_dependency('test-unit', '2.5.5')
  s.add_development_dependency('rake', '~> 10.1')

  s.files = %w[
    codeminer.gemspec
    lib/codeminer.rb
    lib/codeminer/parser.rb
    lib/codeminer/expression_processor.rb
    lib/codeminer/sexp_processor.rb
    lib/codeminer/source_extract.rb
    lib/codeminer/substitution.rb
    lib/codeminer/token.rb
  ]
  s.files += Dir.glob('lib/codeminer/expressions/*.rb')
  s.files += Dir.glob('lib/codeminer/processors/*.rb')

end
