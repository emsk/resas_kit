describe ResasKit::Error do
  describe '.build_error_message' do
    let(:message) { 'This is an error message.' }
    let(:status_code) { '400' }
    let(:description) { 'This is an error description.' }
    let(:basic_error_message) do
      "#{described_class.name.demodulize} - #{message}"
    end

    subject { described_class.build_error_message(response) }

    context 'given message' do
      let(:response) { { 'message' => message } }
      it { is_expected.to eq basic_error_message }
    end

    context 'given message and status code' do
      let(:response) do
        {
          'message' => message,
          'statusCode' => status_code
        }
      end
      it { is_expected.to eq "#{basic_error_message} (STATUS CODE: #{status_code})" }
    end

    context 'given message and description' do
      let(:response) do
        {
          'message' => message,
          'description' => description
        }
      end
      it { is_expected.to eq "#{basic_error_message} (DESCRIPTION: #{description})" }
    end

    context 'given message and status code and description' do
      let(:response) do
        {
          'message' => message,
          'statusCode' => status_code,
          'description' => description
        }
      end
      it { is_expected.to eq "#{basic_error_message} (STATUS CODE: #{status_code}) (DESCRIPTION: #{description})" }
    end
  end
end
