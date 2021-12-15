# frozen_string_literal: true

require_relative '../../lib/parser/csv'

describe Parser::CSV do
  describe '#call' do
    let(:file_path) { File.join(Dir.pwd, 'spec/fixtures/data.csv') }
    let(:file) { File.read(file_path) }
    let(:parser) { described_class.new(file) }

    subject { parser.call }

    it do
      is_expected.to eq(
        [[1, %w[aaa bbb ccc], 1000.33],
         [5, %w[aaaa bbb], 0.001],
         [13, %w[aa bbbb], 10000.00]
        ]
      )
      expect(parser.send(:headers)).to eq(%w[int string money])
    end

    context 'when file has another order of columns' do
      let(:file_path) { File.join(Dir.pwd, 'spec/fixtures/data2.csv') }

      it do
        is_expected.to eq(
          [[1_000.33, 1, %w[aaa bbb ccc]],
           [0.001, 5, %w[aaaa bbb]],
           [10_000.00, 13, %w[aa bbbb]]
          ]
        )
        expect(parser.send(:headers)).to eq(%w[money int string])
      end
    end
  end
end
