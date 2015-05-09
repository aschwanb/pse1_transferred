class Sorter

  # TODO : Refactor this
  #Returns array in which records are sorted by their ranking function (Descending)
  def sort_by_rank(records)
    records = records.uniq.sort_by! {|record| record.get_rank}
    return records.reverse!
  end

  #Returns unique array in which records are sorted by occurrence within array (Descending)
  def sort_by_occurrence(records)
    count = Hash.new(0)
    records.each {|element| count[element] += 1}
    records = records.uniq.sort {|x,y| count[y] <=> count[x]}
    return records
  end

  #Returns unique hash in which records are sorted by "record" => "occurrence" (Descending)
  def sort_by_occurrence_h(input)
    output = input.each_with_object(Hash.new(0)){ |tag, counts| counts[tag] += 1 }
    output = Hash[output.sort_by{ |tags, counts| counts}.reverse]
    return output
  end

end