# frozen_string_literal: true
require_relative 'time_formatter'

class App

  def call(env)
    @env = env
    if @env['PATH_INFO'] == '/time'
      handle_request(@env['QUERY_STRING'])
    else
      response('Page not found', 404)
    end
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def handle_request(params)
    time_f = TimeFormatter.new(params)
    time_f.call
    if time_f.success?
      response(time_f.time_string, 200)
    else
      response(time_f.invalid_string, 400)
    end
  end

  def response(text, status)
    Rack::Response.new(text, status, headers).finish
  end
end
