class LinesCounter

  def initialize(arguments)
    @source_code = arguments[:source_code]
    @one_line_regex = arguments[:one_line_regex] || JAVA_ONE_LINE_COMMENT_REGEX
  end

  def self.lines_of_code(source_code)
    new(source_code: source_code).lines_of_code
  end

  def lines_of_code
    lines = source_code.split("\n")
    return 0 if lines.empty?
    lines_without_one_liners = remove_one_line_comments(lines)
    lines_without_one_liners.count
  end

  private
  
  attr_reader :source_code

  def remove_one_line_comments(lines)
    lines.reject { |line| line =~ JAVA_ONE_LINE_COMMENT_REGEX }
  end

  JAVA_ONE_LINE_COMMENT_REGEX = /^\s*\/\//

end
