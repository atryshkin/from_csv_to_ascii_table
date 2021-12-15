

require_relative '../../../lib/printer/io'

describe Printer::IO::Table do
  describe '#call' do
    let(:data) do
      [
          [1, %w[aaa bbb ccc], 1000.33],
          [5, %w[aaaa bbb], 0.001],
          [13, %w[aa bbbb], 10000.00]
      ]
    end

    subject { described_class.new(data).call }

    it do
      is_expected.to eq("+-----------------+\n" \
                        "| 1|aaa | 1 000,33|\n" \
                        "|  |bbb |         |\n" \
                        "|  |ccc |         |\n" \
                        "+--+----+---------+")
    end
  end
end