# This sample code was an answer to a ruby-talk post
# and shows how to create a structure that maps
# characters to an array of words that start with
# them

t = %w(alpha bravo Charlie Zebra)

result = t.inject(Hash.new) do | words,word |
  first_letter = word[0].upcase
  if words.has_key? first_letter
    words[first_letter] << word
  else
    words[first_letter] = [word]
  end
  words
end
