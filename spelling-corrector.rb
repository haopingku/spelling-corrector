class SpellingCorrector
  def initialize dict
    @alphabets = ('a'..'z').to_a
    @words = File.open(dict){|f| f.read}
      .split(/\W/)
      .map{|s| s.downcase}
      .inject(Hash.new(1)){|h, w| h[w] += 1; h}
  end
  private def edit1 word
    sz = word.size
    # deletion, transposition, alteration, insertion
    [
      (0...sz).map{|i| word[0...i] + word[i+1..-1]},
      (0...sz - 1).map{|i| word[0...i] + word[i+1] + word[i] + word[i+2..-1]},
      (0...sz).map{|i| @alphabets.map{|c| word[0...i] + c + word[i+1..-1]}},
      (0...sz + 1).map{|i| @alphabets.map{|c| word[0...i] + c + word[i..-1]}}
    ]
      .flatten.uniq
  end
  private def edit2 word
    edit1(word).map{|w| edit1(w)}.flatten
  end
  private def known words
    r = words.select{|w| @words.include?(w)}
    r.size > 0 ? r : nil
  end
  def correct s
    s.downcase.split
      .map{|w| known([w]) || known(edit1(w)) || known(edit2(w)) || [w]}
      .map{|ws| ws.max_by{|w| @words[w]}}
      .join(' ')
  end
end
