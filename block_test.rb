def my_block_method
  if block_given?
    (["hello"] * 3).each { | x |
      yield x
    }
  end
end

my_block_method { | x | 
  puts x
}