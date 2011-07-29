# encoding: UTF-8

Dir.glob("*").tap {|files| 
  puts "ファイル数： #{files.length}"
  }.each {|filename| 
    puts "ファイル情報: 【名前】 #{filename} 【サイズ】 #{File.stat(filename).size}"
    }
    
#    ファイル数： 6
#    ファイル情報: 【名前】 binding.rb 【サイズ】 46
#    ファイル情報: 【名前】 block_test.rb 【サイズ】 137
#    ファイル情報: 【名前】 erb_testing.rb 【サイズ】 109
#    ファイル情報: 【名前】 symbol_test.rb 【サイズ】 271
#    ファイル情報: 【名前】 tap.rb 【サイズ】 218
#    ファイル情報: 【名前】 unit_test.rb 【サイズ】 477
