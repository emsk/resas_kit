describe ResasKit::Client do
  let(:api_key) { 'test-api-key' }
  let(:api_version) { 'test-api-version' }
  let(:client) { described_class.new(api_key: api_key, api_version: api_version) }

  describe '.new' do
    subject { client }

    it { is_expected.to be_a described_class }
    it { is_expected.to respond_to(:api_key) }
    it { is_expected.to respond_to(:api_key=) }
    it { is_expected.to respond_to(:api_version) }
    it { is_expected.to respond_to(:api_version=) }
  end

  describe '#api_key' do
    subject { client.api_key }

    context 'when preset @api_key from args' do
      it { is_expected.to eq api_key }
    end

    context 'when preset @api_key from ENV' do
      let(:client) { described_class.new }
      let(:api_key_env) { 'test-api-key-env' }

      before do
        stub_const('ENV', 'RESAS_API_KEY' => api_key_env)
      end

      it { is_expected.to eq api_key_env }
    end
  end

  describe '#api_version' do
    subject { client.api_version }

    context 'when preset @api_version from args' do
      it { is_expected.to eq api_version }
    end

    context 'when preset @api_version from ENV' do
      let(:client) { described_class.new }
      let(:api_version_env) { 'test-api-version-env' }

      before do
        stub_const('ENV', 'RESAS_API_VERSION' => api_version_env)
      end

      it { is_expected.to eq api_version_env }
    end
  end

  shared_examples_for 'a normal http client' do
    before do
      stub_api_request
    end

    subject { response }

    it 'makes a request' do
      subject
      expect(stub_api_request).to have_been_requested
    end

    it { is_expected.to be_a ResasKit::Response }

    describe '#headers' do
      subject { response.headers }
      it { is_expected.to be_a ResasKit::Resource }
    end

    describe '#status' do
      subject { response.status }
      it { is_expected.to eq response_status }
    end

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a ResasKit::Resource }
    end

    context 'when rescue Faraday::ConnectionFailed' do
      let(:message) { 'getaddrinfo: nodename nor servname provided, or not known' }

      before do
        allow_any_instance_of(Faraday::Connection).to receive(:send).and_raise(Faraday::ConnectionFailed, message)
      end

      subject { -> { response } }
      it { is_expected.to raise_error(ResasKit::Error, "ConnectionError - #{message}") }
    end
  end

  let(:request_params) do
    {
      abcdEfgh1234ijklMnop: 'テスト',
      abcdEfgh5678ijklMnop: 'テスト',
      abcdEfgh1234: 'テスト',
      '1234abcdEfgh1234' => { abcdEfgh9012ijklMnop: 'テスト' }
    }
  end

  let(:request_path) { 'test' }

  let(:underscored_request_params) do
    {
      abcd_efgh_1234_ijkl_mnop: 'テスト',
      abcdEfgh_5678_ijklMnop: 'テスト',
      abcdEfgh_1234: 'テスト',
      '1234_abcdEfgh_1234' => { abcd_efgh_9012_ijkl_mnop: 'テスト' }
    }
  end

  describe '#get' do
    let(:request_method) { :get }
    let(:camelized_request_params) { { query: request_params } }
    let(:response_status) { 200 }
    let(:response) { client.get(request_path, underscored_request_params) }

    it_behaves_like 'a normal http client'
  end

  let(:dummy_response) do
    {
      headers: { 'Content-Type' => 'application/json;charset=utf-8' },
      status: response_status,
      body: { 'result' => 'test' }.to_json
    }
  end

  def stub_api_request
    stub_request(request_method, "#{described_class::API_ENDPOINT}/api/#{api_version}/#{request_path}")
      .with({ headers: { 'User-Agent' => described_class::USER_AGENT } }.merge(camelized_request_params))
      .to_return(dummy_response)
  end
end
