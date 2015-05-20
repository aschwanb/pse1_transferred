require 'rails_helper'
require 'spec_helper'

describe DbSearch do
  before :all do
    @dbs = DbSearch.new
  end

  describe "#parse_query" do
    it "has a valid search" do
      search_object = @dbs.parse_query("abc")
      expect(search_object.is_valid?).to eq(true)
    end

    it "has an invalid search" do
      search_object = @dbs.parse_query("")
      expect(search_object.is_valid?).to eq(false)
    end

    it "only takes two search terms" do
      search_object = @dbs.parse_query("one two three")
      expect(search_object.get_search_terms.size).to be < 3
    end
  end

  describe "#single_search" do
    it "has a valid search" do
      search_object = @dbs.parse_query("abc")
      search_object = @dbs.single_search("def", search_object)
      expect(search_object.is_valid?).to eq(true)
    end

    it "has an invalid search" do
      search_object = @dbs.parse_query("")
      search_object = @dbs.single_search("def", search_object)
      expect(search_object.is_valid?).to eq(false)
    end
  end

  # Same as #single_search with multiple entries
  describe "#multi_search" do
    it "has a valid search with multiple entries" do
      search_object = @dbs.parse_query("abc 123")
      search_object = @dbs.single_search("def", search_object)
      expect(search_object.is_valid?).to eq(true)
    end
  end
end