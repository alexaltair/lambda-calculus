require 'rspec'
require './lambda.rb'

describe LambdaString do 

  describe 'reduce' do
    it 'should correctly evaluate the identity expression' do
      LambdaString.new('*\x.xy').reduce.to_s.should == '\y.y'
    end

    it 'should correctly evaluate the empty expression' do
      LambdaString.new('').reduce.to_s.should == ''
    end

    it 'should correctly evaluate the atomic expression' do
      LambdaString.new('x').reduce.to_s.should == 'x'
    end

    it 'should correctly perform beta reduction' do
      LambdaString.new('*\x.*xx\y.ab').reduce.to_s.should == '*\y.ab\y.ab'
    end

    it 'should correctly evaluate closures' do
      LambdaString.new('*\x.xy\y.y').reduce.to_s.should == '*y\y.y' # Fix this.
    end
  end

end