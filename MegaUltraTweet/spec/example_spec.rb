require 'spec_helper'

#describe Block is used to test the Class
describe Example do

  #This will be done ones before all the tests
  before :all do

  end

  #This will be done before each test
  before :each do
    #variables have to be named with an @. So that they can be used in the tests
    @example = Exemple.new "Example"
  end

  #describe Block can be used to test a method. A # is added to the method name
  describe "#new" do

    #the it block is a Test. The string should describe the test. We can use the variables from the before block to test.
    it "returns a new example object" do
        @example.should be_an_instance_of Example
    end

  end

  #We can make tests for the class here without describing a specific method
  it "does something" do

  end

end