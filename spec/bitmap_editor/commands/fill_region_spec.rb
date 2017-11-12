require 'spec_helper'
require './lib/bitmap_editor/bitmap'
require './lib/bitmap_editor/commands/fill_region'

module BitmapEditor
  module Commands
    RSpec.describe FillRegion do
      context 'when it is a bitmap with 3 x 4 dimensions' do
        let(:bitmap) { Bitmap.new(3, 4) }

        before do
          build(
            bitmap,
            [
              %w(A A O),
              %w(A B B),
              %w(A B O),
              %w(A O O),
            ]
          )
        end

        context 'and the chosen color is at the most top-left corner' do
          let(:subject) { described_class.new(bitmap, 0, 0, 'F') }

          it 'colors the region where color "A" is with color "F"' do
            expected = [
              %w(F F O),
              %w(F B B),
              %w(F B O),
              %w(F O O),
            ]

            subject.perform
            assert_equal_bitmap(bitmap, expected)
          end
        end

        context 'and the chosen color is at the most bottom-right corner' do
          let(:subject) { described_class.new(bitmap, 2, 3, 'F') }

          it 'colors the region where color "O" is with color "F"' do
            # x: 2, y: 3, c: F
            expected = [
               # 0 1 2 
              %w(A A O), # 0
              %w(A B B), # 1
              %w(A B F), # 2
              %w(A F F), # 3
            ]

            subject.perform
            assert_equal_bitmap(bitmap, expected)
          end
        end

        context 'and the chosen color in the middle of third row' do
          let(:subject) { described_class.new(bitmap, 1, 1, 'F') }

          it 'colors the region where color "B" is with color "F"' do
            expected = [
              %w(A A O),
              %w(A F F),
              %w(A F O),
              %w(A O O),
            ]

            subject.perform
            assert_equal_bitmap(bitmap, expected)
          end
        end
      end
    end
  end
end
