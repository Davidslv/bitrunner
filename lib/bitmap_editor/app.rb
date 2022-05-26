#!/usr/bin/env ruby
# frozen_string_literal: true

module BitmapEditor
  class App
    def initialize
      main
    end

    def self.start
      new
    end

    private

    def main
      # rubocop:disable Lint/AssignmentInCondition
      while line = Readline.readline('> ', true)
        process_user_input(line) unless line.empty?
      end
      # rubocop:enable Lint/AssignmentInCondition
    end

    def process_user_input(line)
      line    = line.upcase
      command = line.chr
      params  = parsed_params(line.split[1..])

      if commands.keys.include?(command)
        process_command(command, params)
      else
        puts "You need to provide a valid command.\n"
        show_commands_list
      end
    end

    def parsed_params(params)
      *coordinates, color = params
      coordinates.map!(&:to_i) << color
    end

    def commands
      {
        'I' => 'I M N       - Creates a new M x N image with all pixels coloured white (O).',
        'C' => 'C           - Clears the table, setting all pixels to white (O).',
        'L' => 'L X Y C     - Colours the pixel (X,Y) with colour C.',
        'V' => 'V X Y1 Y2 C - Draws a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).',
        'H' => 'H X1 X2 Y C - Draws a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).',
        'F' => %(F X Y C    - Fills the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R.
              Any other pixel which is the same colour as (X,Y) and
              shares a common side with any pixel in R also belongs to this region.),
        'S' => 'S           - Shows the contents of the current image',
        'X' => 'X           - Terminates the session',
        '?' => '?           - Shows the command list'
      }
    end

    def process_command(command, params)
      case command
      when 'I'
        @bitmap = Bitmap.new(*params)
      when 'C'
        @bitmap.clear!
      when 'L'
        @bitmap.set(*params)
      when 'V'
        Commands::DrawVertical.new(@bitmap, *params).perform
      when 'H'
        Commands::DrawHorizontal.new(@bitmap, *params).perform
      when 'F'
        Commands::FillRegion.new(@bitmap, *params).perform
      when 'S'
        puts @bitmap
      when 'X'
        exit 0
      when '?'
        show_commands_list
      end
    end

    def show_commands_list
      commands.each { |_, value| puts value }
    end
  end
end
