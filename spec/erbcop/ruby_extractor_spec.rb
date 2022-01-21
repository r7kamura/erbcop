# frozen_string_literal: true

RSpec.describe Erbcop::RubyExtractor do
  describe '#call' do
    subject do
      described_class.new(
        file_path: file_path,
        source: source
      ).call
    end

    let(:file_path) do
      'dummy.erb'
    end

    context 'with normal code' do
      let(:source) do
        <<~ERB
          <% a %>
        ERB
      end

      it 'returns a collection of Ruby code and its position' do
        is_expected.not_to be_empty
      end
    end

    context 'with comment' do
      let(:source) do
        <<~ERB
          <%# a %>
        ERB
      end

      it 'excludes comment' do
        is_expected.to be_empty
      end
    end
  end
end
