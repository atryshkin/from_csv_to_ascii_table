require_relative '../../../lib/printer/io'

describe Printer::IO::Column do
  describe '#call' do
    let(:value) { 10 }
    let(:width) { 4 }
    let(:index) { 0 }

    subject { described_class.new(value).call(width, index) }

    it { is_expected.to eq('  10|') }

    context 'when value is float' do
      let(:width) { 9 }
      let(:value) { 1_000.003 }
      it { is_expected.to eq(' 1000.003|') }
    end

    context 'when value is string' do
      let(:value) { %w[aaa bbbb] }
      it { is_expected.to eq('aaa |') }

      context 'and index is 1' do
        let(:index) { 1 }
        it { is_expected.to eq('bbbb|') }
      end
    end
  end

  describe '#height' do
    let(:value) { %w[aaa bbbb] }

    subject { described_class.new(value).height }

    it { is_expected.to eq(2) }
  end
end
