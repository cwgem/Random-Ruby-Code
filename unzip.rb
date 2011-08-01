a = [4,5,6]
b = [7,8,9]
c = [1,2,3]

class Array
  def self.unzip(arr)
    arr.inject(Array.new) { |memo,e|
      e.each_with_index do |obj,i|
        memo[i] = [] if memo[i].nil?
        memo[i] << obj
      end
      memo
    }
  end

  def unzip
    unzipped = self.inject(Array.new) { |memo,e|
      e.each_with_index do |obj,i|
        memo[i] = [] if memo[i].nil?
        memo[i] << obj
      end
      memo
    }
    self.replace(unzipped.shift)
    unzipped
  end
end

c = c.zip(a,b)
a,b = c.unzip
p a,b,c

#[4, 5, 6]
#[7, 8, 9]
#[1, 2, 3]

hoge = c.zip(a,b)
c,a,b = Array.unzip hoge
p a,b,c

#[4, 5, 6]
#[7, 8, 9]
#[1, 2, 3]

# ここはArray#zipの打ち切りで問題があるけど…
c = [1,2]
hoge = c.zip(a,b)
c,a,b = Array.unzip hoge
p a,b,c

#[4, 5]
#[7, 8]
#[1, 2]