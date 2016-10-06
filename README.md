# spelling-corrector
This is inspired by Peter Norvig's [spelling corrector](http://norvig.com/spell-correct.html) written in Python. For practice, I rewrote it in Ruby.
Usage:
```bash
$ irb
irb(main):001:0> require_relative 'spelling-corrector'
=> true
irb(main):002:0> correct('speling')
=> "spelling"
irb(main):003:0> s = 'This ia a testt og speling corector'
=> "This ia a testt og speling corector"
irb(main):004:0> s.downcase.split.map{|s| correct(s)}.join(' ')
=> "this in a test of spelling director"
```

