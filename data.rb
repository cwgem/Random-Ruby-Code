require 'yaml'

state = DATA.read
state = (state.empty?) ? [] : YAML::load(state)
state << 1

puts state.inspect

code = File.new(__FILE__).readlines
code = code[0..(code.find_index{ |x| /\A__END__\s*\z/ =~ x })].join("") << "\n" << YAML::dump(state)

File.new(__FILE__, 'w').write(code)

__END__
