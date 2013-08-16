require 'spec_helper'

describe LambdaExpression do

  describe 'new' do

    it "should fail to initizlie the empty string" do
      expect { LambdaExpression.new('') }.to raise_error
    end

    it "should initialize single characters as variables" do
      test_cases = ['x', :a, 'g', :l, 'y', 'z']
      test_cases.each do |expression|
        LambdaExpression.new(expression).kind.should == :variable
      end
    end

    it "should initialize abstractions" do
      test_cases = [[:x, :x] , [:a, 'xa'], ['g', 'ga'], ['x', :x], ['\x.x'], ['\x.\y.xy']]
      test_cases.each do |expression|
        LambdaExpression.new(*expression).kind.should == :abstraction
      end
    end

    it "should initialize applications" do
      test_cases = [[:*, :x, :x], ['*', :a, 'x'], ['*', 'g', 'a'], ['xx'], ['a\x.\y.xy']]
      test_cases.each do |expression|
        LambdaExpression.new(*expression).kind.should == :application
      end
    end

    it "should reject * as an argument in all other cases" do
      test_cases = [[:*], [:*, :*], [:*, '*'], ['*', '*'], ['*', :*], ['x', :*], [:x, :*], [:x, '*'], ['x', '*'], ['*', '*', 'x'], ['*', 'x', '*'], [:*, :*, :x], ['a', '*', '*']]
      test_cases.each do |expression|
        expect { LambdaExpression.new(*expression) }.to raise_error
      end
    end

  end

  describe 'beta_reduce' do

    it "should return the same object if it can't reduce" do
      example = LambdaExpression.new('x')
      example.beta_reduce.should == example
      example.beta_reduce.value.should == example.value # Dubious meaning.

      test_cases = ['\x.x', 'xy', 'x\y.y', 'xyz', '(\a.aab)xy']
      test_cases.each do |expression|
        example = LambdaExpression.new(expression)
        example.beta_reduce.should == example
      end
    end

    it "should return a different object if it can perform beta reduction" do
      test_cases = ['(\x.xx)(\y.yy)', '(\x.xx)(\x.xx)', '(\x.yx)a', '(\a.aab)(xy)']
      test_cases.each do |expression|
        example = LambdaExpression.new(expression)
        example.beta_reduce.should_not == example
      end
    end

  end

  describe 'evaluate' do
    it "should return the same object for expressions that can't be evaluated"

    # I have no idea how to correctly implement this.
    # it "should return with any strategy for expressions with finite reduction steps" do
    #   test_cases = ['x', 'xy'] # Come up with complicated examples.
    #   test_cases.each do |string|
    #     expression = LambdaExpression.new(string)
    #     LambdaExpression.strategies.each do |strategy|
    #       expression.evaluate(strategy).should # ... should what?
    #     end
    #   end
    # end
  end

  describe '===' do

    it "should return true when same up to same variable names, false otherwise" do
      test_cases = { 'x'=>'x', :x=>'x', 'xy'=>'xy', '\a.ba'=>'\a.ba', '(\x.yx)a'=>'(\x.yx)a' }
      test_cases.each do |expression|
        example_self, example_other = LambdaExpression.new(expression[0]), LambdaExpression.new(expression[1])
        example_self.should === example_other
      end

      test_cases = { 'x'=>'y', :x=>'y', 'xy'=>'yx', '\b.ba'=>'\a.ab', '(\x.yx)b'=>'(\x.yx)a' }
      test_cases.each do |expression|
        example_self, example_other = LambdaExpression.new(expression[0]), LambdaExpression.new(expression[1])
        example_self.should_not === example_other
      end
    end

    it "should be reflexive" do
      test_cases = ['x', :x, 'xy', '\a.ba', '(\x.yx)a']
      test_cases.each do |expression|
        example = LambdaExpression.new(expression)
        example.should === example
      end
    end

    it "should be symmetrical" do
      test_cases = { 'x'=>'x', :x=>'x', 'xy'=>'xy', '\a.ba'=>'\a.ba', '(\x.yx)a'=>'(\x.yx)a', 'x'=>'y', :x=>'y', 'xy'=>'yx', '\b.ba'=>'\a.ab', '(\x.yx)b'=>'(\x.yx)a' }
      test_cases.each do |expression|
        example_self, example_other = LambdaExpression.new(expression[0]), LambdaExpression.new(expression[1])
        (example_self === example_other).should == (example_other === example_self)
      end
    end

    # Later, too hard.
    # it "should be transitive" do
    # end

    # pending "write a pending message"

  end

  describe 'deep_clone' do
    it "should copy complex expressions which are alpha_equal and === but not =="
    it "should leave the self untouched"
  end

  describe 'alpha_equal?' do
    it "should return true for expressions with the same structure but different variable names"
  end



  # Can I write a function, has_lambda_properties?, to use in this file?
  # Edge cases
  #   The base cases create objects with correct properties
  # Make complex specific LambdaExpressions and make sure they were initialized correctly
  # Beta reduce leaves self untouched
  # RSpec with random lambdas

end

  # test_cases = [blah]
  # test_cases.each do |expression|
  #   # code
  # end