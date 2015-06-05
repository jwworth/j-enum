module JEnumerable
  def map
    if block_given?
      [].tap { |out| each { |e| out << yield(e) } }
    else
      JEnumerator.new(self, :map)
    end
  end

  def select
    [].tap { |out| each { |e| out << e if yield(e) } }
  end

  # Schwartzian transform!
  def sort_by
    map { |a| [yield(a), a] }.sort.map { |a| a[1] }
  end

  def reduce(operation_or_value=nil)
    case operation_or_value
    when Symbol
      return reduce { |s, e| s.send(operation_or_value, e) }
    when nil
      acc = nil
    else
      acc = operation_or_value
    end

    each { |a| acc.nil? ?  acc = a : acc = yield(acc, a) }
    acc
  end
end
