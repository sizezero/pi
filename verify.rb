#!/usr/bin/env ruby

# rewriting groovy script in ruby since ruby runs on termix

if ARGV.length != 1
  abort "./verify.rb <filename>"
end
filename = ARGV[0]

# read all the digits of pi
pi=""
File.foreach("pi2.csv") { |line|
  line.split("").each { |c|
    if c =~ /[0-9]/
      pi << c
    end
  }
}

# verify the given file against pi
lineno = 0
i = 0
guesses = 0
File.foreach(filename) { |line|
  line = line.chomp
  readline = true
  columnno = 0
  line.split("").each { |c|
    if readline == true
      if c =~ /[0-9]/
        puts "digit checked"
        if i >= pi.length
          abort "ran out of authoritative pi digits at ${pi.length}"
        end
        if c != pi[i]
          puts "failure line #{lineno+1} column #{columnno+1}"
          puts "expected: #{pi[i]}"
          puts "got char: #{c}"
          puts "got line: #{line}"
          exit!
        end
        i += 1
      elsif c == "?"
        i += 1
        guesses += 1
      elsif c == "#"
        readline = false
      end
    end
    columnno += 1
  }
  lineno += 1
}

