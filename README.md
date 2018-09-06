# spelling-corrector
This is inspired by Peter Norvig's [spelling corrector](http://norvig.com/spell-correct.html) written in Python. For practice, I rewrote it in Ruby.
Usage:
```ruby
require 'spelling-corrector.rb'
sc = SpellingCorrector.new('train.txt')
puts sc.correct('This ia a testt og speling corector')
#=> "this in a test of spelling director"
```
