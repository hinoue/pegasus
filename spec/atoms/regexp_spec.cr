require "../spec_helper"

describe Pegasus::Atoms::Regexp do
  it "matches similar strings" do
    regexp = Pegasus::Atoms::Regexp.new(/atch/)
    result, _ = regexp.match?(Pegasus::Context.new("match_me"))
    result.success?.should be_true
  end

  it "doesn't match dissimilar regexps" do
    regexp = Pegasus::Atoms::Regexp.new(/dont/)
    result, _ = regexp.match?(Pegasus::Context.new("match_me"))
    result.success?.should be_false
    result.error.should be_truthy
    result.error.to_s.should match(/Expected \/dont\/ to match match_me at/)
  end

  it "should be equal to another Regexp with the same matcher" do
    regexp = Pegasus::Atoms::Regexp.new(/match/)
    another_regexp = Pegasus::Atoms::Regexp.new(/match/)

    regexp.should eq(another_regexp)
  end

  it "shouldn't be equal to another regexp with different matcher" do
    regexp = Pegasus::Atoms::Regexp.new(/match/)
    another_regexp = Pegasus::Atoms::Regexp.new(/dont/)

    regexp.should_not eq(another_regexp)
  end

  it "redefines label with aka" do
    regexp = Pegasus::Atoms::Regexp.new(/match/)
    regexp.label.should eq(:regexp)
    regexp.aka(:reg)
    regexp.label.should eq(:reg)
  end
end
