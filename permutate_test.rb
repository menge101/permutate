require 'minitest/autorun'
require_relative 'permutate'

class PermutateTest < MiniTest::Test
  def test_permutate_1
    data = %w(1 2 4 5 6 7).map { |s| s.to_i }
    p = Permutate.new data
    p.add_criteria(lambda { |values| values.last + 1 == values[-2] })
    p.add_criteria(lambda { |values| values[1] - values[2] == values[5] })
    p.add_criteria(lambda { |values| values[0] + values[-1] == values[2] + values[3] })
    assert_equal '1, 7, 2, 4, 6, 5', p.analyze
  end

  def test_permutate_2
    data = %w(1 2 4 5 6 7).map { |s| s.to_i }
    p = Permutate.new data
    p.add_criteria(lambda { |values| values.last + 1 == values[-2] })
    p.add_criteria(lambda { |values| values[1] + values[2] == values[5] })
    p.add_criteria(lambda { |values| values[0] + values[-1] == values[2] + values[3] })
    assert_equal '1, 4, 2, 5, 7, 6', p.analyze
  end
end

describe Permutate do
  describe 'when I pass in a non-Enumerable object as data' do
    it 'should raise an exception' do
      assert_raises(StandardError) { Permutate.new 1 }
    end
  end

  describe 'when I attempt to add non-callable code as a criteria' do
    it 'should raise an exception' do
      p = Permutate.new [1]
      assert_raises(StandardError) { p.add_criteria(5) }
    end
  end

  describe 'with only 1 data point' do
    it 'should have 1 permutation' do
      p = Permutate.new([1])
      p.permutation_count.must_equal 1
    end
  end

  describe 'with 2 data points' do
    it 'should have 2 permutations' do
      p = Permutate.new([1, 2])
      p.permutation_count.must_equal 2
    end
  end

  describe 'with 3 data points' do
    it 'should have 3 permutations' do
      p = Permutate.new([1, 2, 3])
      p.permutation_count.must_equal 6
    end
  end

  describe 'with 4 data points' do
    it 'should have x permutations' do
      p = Permutate.new([1, 2, 3, 4])
      p.permutation_count.must_equal 24
    end
  end
end