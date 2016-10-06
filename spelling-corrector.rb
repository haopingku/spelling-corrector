def train words
  words.inject(Hash.new(1)){|h,w| h[w] += 1; h}
end

$nwords = train(File.open('train.txt'){|f| f.read}.split(/\W/).map{|s| s.downcase})
$alphabets = 'abcdefghijklmnopqrstuvwxyz'.split(//)

def edits1 word
  [
    (0...word.size).map{|i| "#{word[0...i]}#{word[i+1..-1]}"}, # deletion
    (0...word.size-1).map{|i| "#{word[0...i]}#{word[i+1]}#{word[i]}#{word[i+2..-1]}"}, # transposition
    (0...word.size).map{|i| $alphabets.map{|c| "#{word[0...i]}#{c}#{word[i+1..-1]}"}}, # alteration
    (0...word.size+1).map{|i| $alphabets.map{|c| "#{word[0...i]}#{c}#{word[i..-1]}"}} # insertion
  ].flatten.uniq
end
def edits2 word
  edits1(word).map{|w| edits1(w)}.flatten
end
def known words
  r = words.select{|w| $nwords.include?(w)}
  r.size > 0 ? r : nil
end
def correct word
  (known([word]) || known(edits1(word)) || known(edits2(word)) || [word])
    .max_by{|w| $nwords[w]}
end

