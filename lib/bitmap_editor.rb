# frozen_string_literal: true

module BitmapEditor
  require 'readline'

  require 'bitmap_editor/validators/base'
  require 'bitmap_editor/validators/coordinates_validator'
  require 'bitmap_editor/errors/out_of_boundaries_error'

  require 'bitmap_editor/commands/draw_vertical'
  require 'bitmap_editor/commands/draw_horizontal'
  require 'bitmap_editor/commands/fill_region'

  require 'bitmap_editor/bitmap'
  require 'bitmap_editor/app'
end
