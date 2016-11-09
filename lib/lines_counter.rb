class LinesCounter

  def initialize(arguments)
    source_code = arguments[:source_code]
    @source_lines = source_code.split("\n")
    @one_line_regex = arguments[:one_line_regex] || JAVA_ONE_LINE_COMMENT_REGEX
  end

  def self.lines_of_code(source_code)
    new(source_code: source_code).lines_of_code
  end

  def lines_of_code
    return 0 if source_lines.empty?
    no_empty_lines = remove_empty_lines(source_lines)
    no_one_liners = remove_one_line_comments(no_empty_lines)
    no_one_liners.count
  end

  private
  
  attr_reader :source_lines, :one_line_regex

  def remove_empty_lines(lines)
    lines.reject { |line| line =~ EMPTY_LINE_REGEX }
  end

  def remove_one_line_comments(lines)
    lines.reject { |line| line =~ one_line_regex }
  end

  JAVA_ONE_LINE_COMMENT_REGEX = /^\s*\/\//
  EMPTY_LINE_REGEX = /^\s*$/

end
