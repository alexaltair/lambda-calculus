Gem::Specification.new do |spec|
  spec.name        = 'lambda-calculus'
  spec.version     = '0.1.1'
  spec.date        = Time.now.strftime("%Y-%m-%d")
  spec.summary     = "A class with methods for creating and evaluating lambda expressions."
  spec.description = "This gem allows users to create and evaluate lambda expression objects from natural string input like '(\\x.xy)(\\a.aba)'."
  spec.authors     = ["Alex Altair"]
  spec.email       = 'alexanderaltair@gmail.com'
  spec.files       = `git ls-files`.split("\n") - %w(.rvmrc .gitignore)
  spec.homepage    = 'https://github.com/alexaltair/lambda-calculus'
  spec.license     = 'MIT'
  spec.test_files  = `git ls-files -- spec/*`.split("\n")
  spec.post_install_message = "* Check out the documentation at #{spec.homepage} *"
  spec.add_development_dependency "rspec"
end
