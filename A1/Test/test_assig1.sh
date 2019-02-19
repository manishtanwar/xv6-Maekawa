#!/usr/bin/expect -f
#
# This Expect script was generated by autoexpect on Sun Jan 21 20:13:12 2018
# Expect and autoexpect were both written by Don Libes, NIST.
#
# Note that autoexpect does not guarantee a working script.  It
# necessarily has to guess about certain things.  Two reasons a script
# might fail are:
#
# 1) timing - A surprising number of programs (rn, ksh, zsh, telnet,
# etc.) and devices discard or ignore keystrokes that arrive "too
# quickly" after prompts.  If you find your new script hanging up at
# one spot, try adding a short sleep just before the previous send.
# Setting "force_conservative" to 1 (see below) makes Expect do this
# automatically - pausing briefly before sending each character.  This
# pacifies every program I know of.  The -c flag makes the script do
# this in the first place.  The -C flag allows you to define a
# character to toggle this mode off and on.

puts "No of Command Line Arguments : [llength $argv]"
set argsCount [llength $argv];
if { $argsCount < 1} {
    puts "Need a user_function name. \n";
    exit 1
} 
set force_conservative 0  ;# set to 1 to force conservative mode even if
			  ;# script wasnt run conservatively originally
if {$force_conservative} {
	set send_slow {1 .1}
	proc send {ignore arg} {
		sleep .1
		exp_send -s -- $arg
	}
}

#
# 2) differing output - Some programs produce different output each time
# they run.  The "date" command is an obvious example.  Another is
# ftp, if it produces throughput statistics at the end of a file
# transfer.  If this causes a problem, delete these patterns or replace
# them with wildcards.  An alternative is to use the -p flag (for
# "prompt") which makes Expect only look for the last line of output
# (i.e., the prompt).  The -P flag allows you to define a character to
# toggle this mode off and on.
#
# Read the man page for more info.
#
# -Don


set timeout -1
set testname [lindex $argv 0];

spawn /bin/sh
expect "$ "
send "make qemu-nox\r"
sleep 1
expect "$"
send "$testname\r"
sleep 1
expect "$"
send "\x01"; send "x"
expect "QEMU: Terminated\r"
expect "$ "
send "exit\r"
expect eof
