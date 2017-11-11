module BitmapHelpers
  def build(bitmap, structure)
    structure.each_with_index do |row, y|
      row.each_with_index do |color, x|
        bitmap.set(x, y, color)
      end
    end
  end

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
