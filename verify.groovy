#!/usr/bin/env groovy

if (args.length!=1) {
  println "verify.groovy <test_file>"
  return
}

File piFile = new File("../pi.csv")
//File piFile = new File("small_pi.txt")

// load pi
List<String> lines = new ArrayList()
StringBuilder sb = new StringBuilder()
piFile.each {
  lines.add(it)
  it.each {
    char c = it.charAt(0)
    if (Character.isDigit(c)) {
      sb.append(c)
    }
  }
}

// verify the given file against pi
int lineno=0
int i=0
int guesses=0
new File(args[0]).each { line ->
  boolean readLine=true
  int columnno=0
  line.each {
    if (readLine) {
      char c = it.charAt(0)
      if (Character.isDigit(c)) {
	if (i >= sb.size()) {
	  println "ran out of authoritative pi digits at ${sb.size()}"
	  System.exit(1)
	}
	if (c!=sb.charAt(i)) {
	  println "failure line ${lineno+1} column ${columnno+1}"
	  println "expected: ${sb.charAt(i)}"
	  println "got char: $c"
	  println "got line: $line"
	  System.exit(1)
	}
	++i
      } else if (c=='?') {
	++i
	++guesses
      } else if (c=='#') {
	readLine=false
      }
    }
    ++columnno
  }
  ++lineno
}

println "$i digits verified"
println "$guesses guesses"
