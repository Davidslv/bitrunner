require './lib/bitmap_editor/bitmap'
require './lib/bitmap_editor/commands/draw_horizontal'

module BitmapEditor
  module Commands
    RSpec.describe DrawHorizontal do
      context 'when it is a bitmap with 3 x 4 dimensions' do
        let(:bitmap) { Bitmap.new(3, 4) }
        let(:subject) { described_class.new(bitmap, 0, 2, 1, 'A') }

        it 'colors the 2nd row between X1 and X2 coordinates' do
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

      context 'when it is a bitmap with 6 x 4 dimensions' do
        let(:bitmap) { Bitmap.new(6, 4) }
        let(:subject) { described_class }

        context 'and there are more than one horizontal segment' do
          it 'color the given coordinates' do
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

          it 'color the given coordinates' do
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

          it 'overrides any previous colors given by the new horizontal coordinates' do
            expected = [
              %w(O O O O O O),
              %w(O A A A O O),
              %w(O O B D D D),
              %w(O O O O O O),
            ]

            subject.new(bitmap, 1, 3, 1, 'A').perform
            subject.new(bitmap, 2, 4, 2, 'B').perform

            # Overrides color B with D
            subject.new(bitmap, 3, 5, 2, 'D').perform

            assert_equal_bitmap(bitmap, expected)
          end
        end
      end
    end
  end
end
