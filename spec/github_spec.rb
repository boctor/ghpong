require './github.rb'

describe GitHub do
  describe "issue" do
    it "should return nil when no issue detected" do
      GitHub.issue("fixes some stuff").should be_nil
      GitHub.issue("fixes gh-more").should be_nil
      GitHub.issue("fixes #34").should be_nil
    end

    it "should return issue number prefixed by gh-" do
      GitHub.issue("fixes gh-34").should == "34"
    end

    it "should return issue number prefixed by GH-" do
      GitHub.issue("fixes GH-34").should == "34"
    end
  end

  describe "closed_issue" do
    it "should return issue number of closed issue" do
      GitHub.closed_issue("fixes gh-34").should == "34"
      GitHub.closed_issue("fixes GH-34").should == "34"
      GitHub.closed_issue("fixes #34").should == "34"
    end

    it "should return nil when issue not closed" do
      GitHub.closed_issue("references GH-34").should be_nil 
    end
  end

  describe "nonclosing_issue" do
    it "should return issue number of issue prefixed by gh-" do
      GitHub.nonclosing_issue("changes gh-34").should == "34"
      GitHub.nonclosing_issue("changes GH-34").should == "34"
    end

    it "should return nil when issue doesnt have prefix" do
      GitHub.nonclosing_issue("changes #34").should be_nil
    end

    it "should return nil when no issue referenced" do
      GitHub.nonclosing_issue("changes nothing").should be_nil
    end

    it "should return nil when issue referenced is being closed" do
      GitHub.nonclosing_issue("fixes gh-34").should be_nil 
      GitHub.nonclosing_issue("fixes GH-34").should be_nil
      GitHub.nonclosing_issue("fixes #34").should be_nil 
      GitHub.nonclosing_issue("closes #34").should be_nil 
      GitHub.nonclosing_issue("Closes gh-34").should be_nil 
    end
  end
end
