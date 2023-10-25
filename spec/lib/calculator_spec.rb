# frozen_string_literal: true

require 'calculator'

describe Calculator do
  describe '.perform' do
    subject { described_class.new(expression).perform }

    context 'performing single simple operation' do
      context 'using +' do
        let(:expression) { "1+2" }

        it 'succeeds' do
          expect(subject).to eq(3)
        end
      end

      context 'using -' do
        let(:expression) { "3-2" }

        it 'succeeds' do
          expect(subject).to eq(1)
        end
      end

      context 'using *' do
        context 'for small numbers' do
          let(:expression) { "3*2" }

          it 'succeeds' do
            expect(subject).to eq(6)
          end
        end

        context 'for big numbers' do
          let(:expression) { "42323*2323" }

          it 'succeeds' do
            expect(subject).to eq(98316329)
          end
        end

        context 'for very big numbers' do
          let(:very_big_number) { 999999999999999999999999999999999999999999999999999999999999999999999999 }
          let(:expression) { "#{very_big_number}*#{very_big_number}" }

          it 'succeeds' do
            expect(subject).to be > very_big_number
          end
        end
      end

      context 'using /' do
        context 'for integer response' do
          let(:expression) { "4/2" }

          it 'succeeds' do
            expect(subject).to eq(2)
          end
        end

        context 'for floating response' do
          let(:expression) { "5/2" }

          it 'returns integer value' do
            expect(subject).to eq(2)
          end
        end

        context 'for zero division' do
          let(:expression) { "5/0" }

          it 'raises ZeroDivisionError' do
            expect { subject }.to raise_error(ZeroDivisionError)
          end
        end
      end
    end

    context 'performing multiple operations' do
      context 'using simple operations' do
        let(:expression) { "1+2*3-4/2" }

        it 'succeeds' do
          expect(subject).to eq(5)
        end
      end

      context 'using expression with parentheses' do
        context 'using single level of parentheses' do
          let(:expression) { "1+2*(3-4)/2" }

          it 'succeeds' do
            expect(subject).to eq(0)
          end
        end

        context 'using multiple levels of parentheses' do
          let(:expression) { "1+5*(6-4)/(2+15/(4+1))" }

          it 'succeeds' do
            expect(subject).to eq(3)
          end
        end
      end
    end

    context 'having invalid expression' do
      context 'with invalid symbols' do
        let(:expression) { "abc" }

        it 'raises ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'with invalid operation' do
        let(:expression) { "2**2" }

        it 'raises ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'with invalid parentheses' do
        let(:expression) { ")1+3(" }

        it 'raises ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end
  end
end