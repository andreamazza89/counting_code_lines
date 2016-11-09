class LinesCounter

  def initialize(arguments)
    source_code = arguments[:source_code]
    @source_lines = source_code.split("\n")

########################maybe extract the instances below as a Rule class?######
    @one_line_regex = arguments[:one_line_regex] || JAVA_ONE_LINE_COMMENT_REGEX
    @multiline_start_regex = arguments[:multiline_start_regex] || 
                               JAVA_MULTILINE_COMMENT_START_REGEX

    @multiline_end_regex = arguments[:multiline_end_regex] || 
                               JAVA_MULTILINE_COMMENT_END_REGEX
################################################################################
  end

  def self.lines_of_code(source_code)
    new(source_code: source_code).lines_of_code
  end

  def lines_of_code
    return 0 if source_lines.empty?

    no_empty_lines = remove_empty_lines(source_lines)
    no_multilines = remove_multiline_comments(no_empty_lines)
    no_multiline_no_one_line = remove_one_line_comments(no_multilines)

    no_multiline_no_one_line.count
  end

  private
  
  attr_reader :source_lines, :one_line_regex, 
              :multiline_start_regex, :multiline_end_regex

  def remove_empty_lines(lines)
    lines.reject { |line| line =~ EMPTY_LINE_REGEX }
  end

  def remove_one_line_comments(lines)
    lines.reject { |line| line =~ one_line_regex }
  end

  def remove_multiline_comments(lines)
    inside_comment = false
    output = []
    lines.each do |line|
      inside_comment = true if line =~ multiline_start_regex
      output << line unless inside_comment
      inside_comment = false if line =~ multiline_end_regex
    end
    output
  end

  JAVA_ONE_LINE_COMMENT_REGEX = /^\s*\/\//
  EMPTY_LINE_REGEX = /^\s*$/
  JAVA_MULTILINE_COMMENT_START_REGEX = /^\s*\/\*/
  JAVA_MULTILINE_COMMENT_END_REGEX = /\*\//

end
