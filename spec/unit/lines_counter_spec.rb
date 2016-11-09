describe LinesCounter, '#lines_of_code' do

  it 'returns 0 for an empty string' do
    expect(described_class.lines_of_code("")).to eq 0
  end

  it 'returns 1 for a string with a single line' do
    expect(described_class.lines_of_code("private int number = 3")).to eq 1
  end

end
