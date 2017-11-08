require 'spec_helper'
require './lib/bitmap_editor/bitmap'
require './lib/bitmap_editor/commands/draw_horizontal'

module BitmapEditor
  module Commands
    RSpec.describe DrawHorizontal do
      def assert_equal_bitmap(bitmap, expected)
        expected.each_with_index do |row, y|
          row.each_with_index do |_column, x|
            expect(
              bitmap.get(x, y)
            ).to eql expected[y][x]
          end
        end
      end

      context 'when receives coordinates' do
        let(:bitmap) { Bitmap.new(3, 4) }
        let(:subject) { described_class.new(bitmap, 0, 2, 1, 'A') }

        #   0 1 2
        # 0 O O O
        # 1 A A A
        # 2 O O O
        # 3 O O O

        it 'should color the coordinates between given x coordinates' do
          expected = [
            %w(O O O),
            %w(A A A),
            %w(O O O),
            %w(O O O),
          ]

          subject.perform
          assert_equal_bitmap(bitmap, expected)
        end
      end

      context 'when receives coordinates' do
        let(:bitmap) { Bitmap.new(6, 4) }
        let(:subject) { described_class }

        #   0 1 2 3 4 5
        # 0 O O O O O O
        # 1 O A A A O O
        # 2 O O B B B O
        # 3 O O O O O O

        it 'should color the coordinates between given x xx coordinates' do
          expected = [
            %w(O O O O O O),
            %w(O A A A O O),
            %w(O O B B B O),
            %w(O O O O O O),
          ]

          subject.new(bitmap, 1, 3, 1, 'A').perform
          subject.new(bitmap, 2, 4, 2, 'B').perform

          assert_equal_bitmap(bitmap, expected)
        end
      end
    end
  end
end
