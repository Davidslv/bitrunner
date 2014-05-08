require 'spec_helper'
require 'bitmap_editor/image'

module BitmapEditor
  describe Image do
    subject { described_class }

    describe "#new" do
      context 'when image is bigger than 250x250' do
        it 'raises an error' do
          expect {
            subject.new(251, 251)
          }.to raise_error
        end
      end

      context 'when image is equal to 250x250' do
        it 'does not raises an error' do
          expect {
            subject.new(250, 250)
          }.to_not raise_error
        end

        it 'should have an image with 62500 pixels' do
          image = subject.new(250, 250)
          image.pixels.flatten.should have(62500).pixels
        end
      end

      describe "#show" do
        subject { described_class.new(5,5) }

        its(:show) { should eql("OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO") }
      end

      describe "#colour" do
        let(:image) { subject.new(4,4) }

        it 'colours the image with A at X1 Y2' do
          image.colour(1, 2, 'A')
          image.show.should eql("OOOO\nAOOO\nOOOO\nOOOO")
        end
      end

      describe "#clear" do
        let(:image) { subject.new(4,4) }

        it 'clears the image to default value O' do
          image.colour(2, 2, 'B')
          image.clear
          image.show.should eql("OOOO\nOOOO\nOOOO\nOOOO")
        end
      end
    end
  end

end
