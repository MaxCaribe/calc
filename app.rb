# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/calculator'

get '/calculator' do
  puts params['expression']
  result = Calculator.new(params['expression']).perform
  [200, { expression: params['expression'], result: }.to_json]
rescue ArgumentError => e
  [422, { error: e.message }.to_json]
end
