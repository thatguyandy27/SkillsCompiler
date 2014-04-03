require 'spec_helper'
require 'date'

describe SkillTotal do
  before do
    @skill_total = SkillTotal.new(:name => "Ruby", :count => 5, :date => Date.today())
  end

  subject { @skill_total}

  it { should respond_to(:name)}
  it { should respond_to(:count)}
  it { should respond_to(:date)}
  it { should be_valid}

  describe "When name is not present" do
    before{ @skill_total.name = ' '}
    it{ should_not be_valid}
  end

  describe "When count is an invalid" do
    describe "negative count" do 
      before { @skill_total.count = -1}
      it {should_not be_valid}
    end

    describe "zero count" do 
      before {@skill_total.count = 0 }
      it {should_not be_valid}
    end

    describe "non-numeric count" do
      before {@skill_total.count = " "}
      it {should_not be_valid}
    end
  end

  describe "When date is invalid" do
    before {@skill_total.date = ' '}
    it {should_not be_valid}
  end

  describe "Retrieve list of skills" do
    
  end
end
