describe ResasKit::Response::RaiseError do
  let(:faraday_env_mock) { instance_double('faraday env') }
  let(:faraday_env_headers) { { 'Content-Type' => 'application/json;charset=UTF-8' } }
  let(:faraday_env_status) { 200 }
  let(:status_code) { nil }
  let(:message) { 'This is an error message.' }
  let(:description) { 'This is an error description.' }
  let(:faraday_env_body) do
    {
      'statusCode' => status_code.to_s,
      'message' => message,
      'description' => description
    }.to_json
  end
  let(:response) { described_class.new(faraday_env_mock) }

  before do
    allow(faraday_env_mock).to receive(:response_headers).and_return(faraday_env_headers)
    allow(faraday_env_mock).to receive(:status).and_return(faraday_env_status)
    allow(faraday_env_mock).to receive(:body).and_return(faraday_env_body)
  end

  describe '#on_complete' do
    subject { -> { response.on_complete(faraday_env_mock) } }

    context 'when json body contains `result`' do
      let(:faraday_env_body) do
        {
          'message' => nil,
          'result' => []
        }.to_json
      end
      it { is_expected.not_to raise_error }
    end

    context 'when 400 Bad Request' do
      let(:status_code) { 400 }
      it_behaves_like 'raise errors'
    end

    context 'when 403 Forbidden' do
      let(:status_code) { 403 }
      it_behaves_like 'raise errors'
    end

    context 'when 404 Not Found' do
      let(:status_code) { 404 }
      it_behaves_like 'raise errors'
    end

    context 'when 429 Too Many Requests' do
      let(:status_code) { 429 }
      it_behaves_like 'raise errors'
    end

    context 'when unexpected status code' do
      let(:status_code) { 500 }
      it { is_expected.to raise_error(ResasKit::Error, "UnexpectedError - #{message} (STATUS CODE: #{status_code}) (DESCRIPTION: #{description})") }
    end
  end

  context 'after #on_complete' do
    describe 'ResasKit::Response::RaiseError' do
      before do
        allow(response).to receive(:success?).and_return(true)
        response.on_complete(faraday_env_mock)
      end

      describe '#headers' do
        subject { response.headers }
        it { is_expected.to eq faraday_env_headers }
      end

      describe '#status' do
        subject { response.status }
        it { is_expected.to eq faraday_env_status }
      end

      describe '#body' do
        subject { response.body }
        it { is_expected.to eq faraday_env_body }
      end
    end
  end
end
