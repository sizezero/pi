#!/usr/bin/env ruby

require 'fileutils'

i = 1
while true do
  filename = "try/#{'%05d' % i}.txt"
  if !File.exist?(filename)
    FileUtils.cp("template.txt", filename)
    exit
  end
  i += 1
end
  
