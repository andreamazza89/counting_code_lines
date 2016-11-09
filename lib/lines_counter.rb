class LinesCounter

  def self.lines_of_code(source_code)
    lines = source_code.split("\n")
    return 0 if lines.empty?
    lines_without_one_liners = remove_one_line_comments(lines)
    lines_without_one_liners.count
  end

  def self.remove_one_line_comments(lines)
    lines.reject { |line| line =~ /^\/\//}
  end

end
