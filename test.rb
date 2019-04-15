#!/usr/bin/env ruby
#
# 

# Convert text to an array to avoid UTF-8 complexity.
puts("Reading file.")
text = File.read('corpus.txt')

def word_boundary?(arr, i) 
  case arr[i] 
  when "\r"
    true
  when "\n"
    true
  when "\t"
    true
  when " "
    true
  else
    false
  end
end

def time_this(&call)
  start_time = Process.clock_gettime(Process::CLOCK_REALTIME, :nanosecond)
  call.call()
  stop_time = Process.clock_gettime(Process::CLOCK_REALTIME, :nanosecond)
  puts("time #{(stop_time - start_time) / 1000000.0}ms")
end


def find_shortest(text)
  i = 0    # The index of the word start we are considering.
  loc = 0  # The location of the longest work for final reporting.
  len = 1  # The length of the longest word.
  time_this do
    while i < text.length do

      new_longest = true

      # Check backwards. If found before len, rewind to that and step.
      len.times do |back_i|
        if word_boundary?(text, i - back_i)
          new_longest = false
          break
        end
      end

      if new_longest
        loc = i - len + 1
        until word_boundary?(text, i)
          i += 1
        end
        len = i - loc
      else
        i += len
      end

    end
  end
  puts("longest #{len} \"#{text[loc...loc+len]}\"")
end

find_shortest(text)
find_shortest(text)
find_shortest(text)
find_shortest(text)


