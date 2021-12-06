class TimeFormatter
  # require 'pry'
  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(params)
    @params = params.gsub('format=', '').split('%2C')
    @unknown_format = []
    @output_format = []
  end

  def call
    @params.each do |format|
      if FORMATS[format]
        @output_format << FORMATS[format]
      else
        @unknown_format << format
      end
    end
  end

  def success?
    @unknown_format.empty?
  end

  def time_string
    Time.now.strftime(@output_format.join('-'))
  end

  def invalid_string
    "Unknown time format #{@unknown_format}" unless success?
  end
end
