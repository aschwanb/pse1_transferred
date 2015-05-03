module Utility

  def build_pair_hash(anchor, pairs)
    paired_hash = Hash.new
    pairs.each do |pair|
      pair.hashtag_first_id == anchor.id ? paired_hash.store(pair.hashtag_second, pair.get_rank)
        : paired_hash.store(pair.hashtag_first, pair.get_rank)
    end
    return paired_hash
  end
end