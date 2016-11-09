describe LinesCounter, '#lines_of_code' do

  context 'default - java' do
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

    it 'returns 0 for a string with a single line being a comment ' do
      expect(described_class.lines_of_code("//private int number = 3;")).to eq 0
    end

    it 'returns 0 for a string with a single line being a comment, starts with space' do
      expect(described_class.lines_of_code(" //private int number = 3;")).to eq 0
    end

    it 'ignores empty lines' do 
      expect(described_class.lines_of_code(" \n private int number = 3;")).to eq 1
    end

    it 'ignores one-line-comment anchors if they are not at the start of the line' do 
      expect(described_class.lines_of_code("private String link = //missing")).to eq 1
    end

    it 'ignores multi-line comments (example with no lines of code)' do
      expect(described_class.lines_of_code("/* comment \n * com \n ent */")).to eq 0
    end

    it 'ignores multi-line comments (space before opening tag)' do
      expect(described_class.lines_of_code(" /* comment \n * com \n ent */")).to eq 0
    end

    it 'does include a line if a multiline comment starts AND ends on it after some code' do
      expect(described_class.lines_of_code("private int test; /* comment */ ")).to eq 1
    end

    it 'works with online example one' do
      expect(described_class.lines_of_code(ONLINE_EXAMPLE_ONE)).to eq 3
    end

    it 'works with online example two' do
      expect(described_class.lines_of_code(ONLINE_EXAMPLE_TWO)).to eq 5
    end
  end
end

ONLINE_EXAMPLE_ONE = "// This file contains 3 lines of code
public interface Dave {
  /**
   * count the number of lines in a file
   */
  int countLines(File inFile); // not the real signature!
}"

ONLINE_EXAMPLE_TWO ="/*****
 * This is a test program with 5 lines of code
 *  \/* no nesting allowed!
 //*****//***/// Slightly pathological comment ending...

public class Hello {
    public static final void main(String [] args) { // gotta love Java
        // Say hello
      System./*wait*/out./*for*/println/*it*/(\"Hello/*\");
    }

}"
