

require_relative '../../../lib/printer/io'

describe Printer::IO::Row do
  describe '#call' do
    let(:row_data) { [1, %w[aaa bbbb ccc], 1000.33] }
    let(:row) { described_class.new(row_data) }

    subject { row.call }

    it do
      is_expected.to eq("|1|aaa |1000.33|\n" \
                        "| |bbbb|       |\n" \
                        "| |ccc |       |\n")
    end

    context 'when value is float' do
      let(:width) { 9 }
      let(:value) { 1_000.003 }
      # it { is_expected.to eq(' 1000.003|') }
    end
  end

  describe '#height' do
    let(:row_data) { [1, %w[aaa bbbb ccc], 1000.33] }
    let(:row) { described_class.new(row_data) }

    subject { row.height }

    it { is_expected.to eq(3) }
  end

  describe '#width' do
    let(:row_data) { [1, %w[aaa bbbb ccc], 1000.33] }
    let(:row) { described_class.new(row_data) }

    subject { row.width }

    it { is_expected.to eq(12) }
  end
end
