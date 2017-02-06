class APIConstraints
  attr_reader :version

  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(request)
    @default || request.headers[:accept].include?("version=#{@version}")
  end

end