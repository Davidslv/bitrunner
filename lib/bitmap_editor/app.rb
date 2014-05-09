#!/usr/bin/env ruby

require 'readline'

module BitmapEditor

  class App

    def initialize
      main
    end

    private

    def main
      while line = Readline.readline('>', true)
        process_user_input(line) unless line.empty?
      end
    end

    def process_user_input(line)
      command  = line[0].upcase
      params   = line.upcase.split[1..-1]

      if commands.keys.include?(command)
        process_command(command, params)
      else
        puts "You need to provide a valid command.\n"
        show_commands_list
      end
    end

    def commands
      {
        "I" => 'I M N       - Creates a new M x N image with all pixels coloured white (O).',
        "C" => 'C           - Clears the table, setting all pixels to white (O).',
        "L" => 'L X Y C     - Colours the pixel (X,Y) with colour C.',
        "V" => 'V X Y1 Y2 C - Draws a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).',
        "H" => 'H X1 X2 Y C - Draws a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).',
        "F" => "F X Y C     - Fills the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R.\n\t\tAny other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.",
        "S" => 'S           - Shows the contents of the current image',
        "X" => 'X           - Terminates the session',
        "?" => '?           - Shows the command list'
      }
    end

    def process_command(command, params)
      case command
      when 'I'
        @image = Image.new(*params)
      when 'C'
        @image.clear
      when 'L'
        @image.colour(*params)
      when 'V'
        @image.vertical(*params)
      when 'H'
        @image.horizontal(*params)
      when 'F'
        @image.fill(*params)
      when 'S'
        puts @image.show
      when 'X'
        exit 0
      when '?'
        show_commands_list
      end

    end

    def show_commands_list
      commands.each{|_, value| puts value }
    end
  end
end
