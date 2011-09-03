require 'curses'
# Otherwise we have to put Curses:: before everything
include Curses

# setup the default screen (stdscr)
init_screen
# The nl(CURSES) function enables a mode in which carriage return is translated to newline on input. 
# The nonl(CURSES) function disables the above translation. Initially, the above translation is enabled.
nonl
# Normally, the tty driver buffers typed characters until a newline or carriage return is typed. 
# The cbreak routine disables line buffering and erase/kill character-processing (interrupt and 
# flow control characters are unaffected), making characters typed by the user immediately available 
# to the program.
cbreak
# The echo and noecho routines control whether characters typed by the user are echoed by getch as 
# they are typed.
noecho
# These routines write the characters of the (null-terminated) character string str on the given window.
addstr "Hello World"
# virtual screen -> physical screen
refresh
# Wait for user input before ending
getch
# free up resources!
close_screen
