# This gets the first line by checking if the headers are set and setting them if they're not
if $headers.nil?
  $headers = $F
  next
end

# Because commands with spaces or argument lists
$command = $F[$headers.length - 1..$F.length - 1].join ' '

# Now throw the elements into headers
# Use inject since we're doing accumulation on something
pi = (0...$headers.length).each.inject(Hash.new) {|process,i|
  #p process, i, $headers
  # Command is a one off special case
  if $headers[i] == "COMMAND"
    process[$headers[i]] = $command
  else
    process[$headers[i]] = $F[i]
  end
  
  # Then return this so the inject memo gets properly set
  process
}

puts "#{pi["PID"]} #{pi["COMMAND"]} #{pi['%CPU']} #{pi['%MEM']}" if pi["COMMAND"] =~ /Application/ and pi["%CPU"].to_f > 1.0