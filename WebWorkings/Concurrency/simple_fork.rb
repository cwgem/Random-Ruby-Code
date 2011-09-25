# Parent process
3.times do
  fork do
    # child process logic here
    trap('INT') { exit }
    loop { puts "Hello from #$$"; sleep 3 }
    # end child process logic
  end
end

# Parent process logic continues
trap('INT') { exit }

Process.waitall
