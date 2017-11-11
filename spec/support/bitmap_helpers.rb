module BitmapHelpers
  def assert_equal_bitmap(bitmap, expected)
    expected.each_with_index do |row, y|
      row.each_with_index do |_column, x|
        expect(
          bitmap.get(x, y)
        ).to eql expected[y][x]
      end
    end
  end
end
