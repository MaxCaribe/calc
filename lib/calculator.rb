# frozen_string_literal: true

class Calculator
  ALLOWED_ACTIONS = %w[+ - * / ( )]

  def initialize(expression)
    @expression = expression
  end

  def perform
    validate_expression
    eval expression
  end

  private

  attr_reader :expression

  def validate_expression
    actions = expression.scan(/\D/)
    raise ArgumentError.new('Invalid expression') unless actions.all? { |action| ALLOWED_ACTIONS.include?(action) }

    validate_parentheses(actions)

    plain_expression = expression.gsub(/\)|\(/, '')
    long_actions = plain_expression.scan(/\D+/)
    raise ArgumentError.new('Invalid expression') unless long_actions.all? { |action| ALLOWED_ACTIONS.include?(action) }
  end

  def validate_parentheses(actions)
    parentheses = 0
    actions.each do |action|
      parentheses += 1 if action == '('
      parentheses -= 1 if action == ')'
      raise ArgumentError.new('Invalid expression') if parentheses < 0
    end
    raise ArgumentError.new('Invalid expression') if parentheses > 0
  end
end
