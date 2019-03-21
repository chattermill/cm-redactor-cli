require 'yaml'

class Sensitive
  attr_reader :config

  REDACTED = '[redacted]'.freeze

  def initialize
    @config = YAML::load_file(File.join(__dir__, 'rules.yml'))
  end

  def rules
    config['Rules']
  end

  def remove_sensitive_data str
    rules.each do |rule|
      regex = Regexp.new(rule.values.first)
      str = str&.gsub(regex, REDACTED)
    end
    str
  end

end

puts Sensitive.new.remove_sensitive_data(ARGV[0])
