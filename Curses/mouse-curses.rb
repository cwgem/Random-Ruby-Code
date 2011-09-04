require 'curses'
include Curses

class MenuWindow < Window

  WIDTH = 30
  HEIGHT = 10
  X = 1
  Y = 1
  CHOICES = ['Choice 1', 'Choice 2', 'Choice 3', 'Choice 4', 'Exit']

  def initialize()
    super(HEIGHT,WIDTH,Y,X)
  end

  def print_menu(highlight=0)
    self.box 0,0
    x = y = 2
    CHOICES.each_with_index do | choice, i |
      self.setpos y, x
      
      if highlight == i
        self.attron A_REVERSE
        self.addstr choice
        self.attroff A_REVERSE
      else
        self.addstr choice
      end

      y += 1
    end
    self.refresh
  end

  def report_choice(mouse_x, mouse_y)
    i = X + 2
    j = Y + 3

    CHOICES.each_with_index do | choice, choice_idx |
      return [choice,choice_idx] if mouse_y == j + choice_idx and mouse_x >= i and mouse_x <= i + choice.length
    end
  end

end

init_screen

begin
  clear
  cbreak
  noecho
  stdscr.keypad(true)

  attron A_REVERSE
  setpos 23,1
  addstr "Click on Exit to quit (Works best in a virtual console)"
  refresh
  attroff A_REVERSE

  menu_win = MenuWindow.new
  menu_win.print_menu

  mousemask(BUTTON1_PRESSED)

  catch(:breakout) {
    while(true)
     c = getch
     case c
     when KEY_MOUSE
       mouse_event = getmouse
       if mouse_event
         selection,index = menu_win.report_choice(mouse_event.x + 1, mouse_event.y + 1)
         throw :breakout if selection.eql? "Exit"
         setpos 22,1
         addstr "Choice made is: #{selection}"
         refresh
       end
       menu_win.print_menu index
     end # case c
    end # while(true)
  }
ensure
  close_screen
end
