require 'spec_helper'
require './lib/bitmap_editor/bitmap'
require './lib/bitmap_editor/commands/draw_vertical'

module BitmapEditor
  module Commands
    RSpec.describe DrawVertical do
      context 'when it is a bitmap with 3 x 4 dimensions' do
        let(:bitmap) { Bitmap.new(3, 4) }

        it 'colors the bitmap on 2nd column between Y1 and Y2' do
          subject = DrawVertical.new(bitmap, 1, 0, 2, "A")

          expected = [
            %w(O A O),
            %w(O A O),
            %w(O A O),
            %w(O O O),
          ]

          subject.perform
          assert_equal_bitmap(bitmap, expected)
        end
      end

      context 'when it is a bitmap with 6 x 4 dimensions' do
        let(:bitmap) { Bitmap.new(6, 4) }
        let(:subject) { described_class }

        context 'and there are more than one vertical segment' do
          it 'colors the given coordinates' do
            expected = [
              %w(A O O C O O),
              %w(A O O C O D),
              %w(A O B O O D),
              %w(O O B O O O),
            ]

            subject.new(bitmap, 0, 0, 2, 'A').perform
            subject.new(bitmap, 2, 2, 3, 'B').perform
            subject.new(bitmap, 3, 0, 1, 'C').perform
            subject.new(bitmap, 5, 1, 2, 'D').perform

            assert_equal_bitmap(bitmap, expected)
          end

          it 'overrides any previous colors given by the new vertical coordinates' do
            expected = [
              %w(A O O B O O),
              %w(A O O B O A),
              %w(A O B O O A),
              %w(O O B O O O),
            ]

            subject.new(bitmap, 0, 0, 2, 'A').perform
            subject.new(bitmap, 2, 2, 3, 'B').perform
            subject.new(bitmap, 3, 0, 1, 'C').perform
            subject.new(bitmap, 5, 1, 2, 'D').perform

            # override colors C & D
            subject.new(bitmap, 3, 0, 1, 'B').perform
            subject.new(bitmap, 5, 1, 2, 'A').perform

            assert_equal_bitmap(bitmap, expected)
          end
        end
      end
    end
  end
end
