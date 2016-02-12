class Permutate
  attr_accessor :data, :criteria

  def initialize(data)
    raise 'Data set is not contained in an Enumerable object' unless data.respond_to? :each
    @data = data
    @criteria = Array.new
  end

  def add_criteria(lamb)
    raise 'Criteria is not a Proc or Lambda' unless lamb.respond_to? :call
    @criteria << lamb
  end

  def permutation_count
    @data.permutation.size
  end

  def analyze
    @data.permutation.each do |p|
      result = @criteria.all? { |c| c.call(p) }

      if result
        return p.join(', ')
        break
      end
    end
  end
end