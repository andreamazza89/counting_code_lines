describe LinesCounter, '#lines_of_code' do

  it 'returns 0 for an empty string' do
    expect(described_class.lines_of_code("")).to eq 0
  end

  it 'returns 1 for a string with a single line that is not a comment' do
    expect(described_class.lines_of_code("private int number = 3;")).to eq 1
  end

#At this point, I start thinking that it would make a lot of sense to use start/end
#comment anchors, should I let this shape future tests? or should future tests 
#make this emerge? Maybe I should pretend the Client is only asking for one language
#but keep an eye open for potential new languages...

  it 'returns 0 for a string with a single line being a comment (java)' do
    expect(described_class.lines_of_code("//private int number = 3;")).to eq 0
  end

  it 'returns 0 for a string with a single line being a comment, starts with space (java)' do
    expect(described_class.lines_of_code(" //private int number = 3;")).to eq 0
  end

  it 'ignores empty lines' do 
    expect(described_class.lines_of_code(" \n private int number = 3;")).to eq 1
  end

end
