shared_examples_for 'raise errors' do
  let(:error_class_name) do
    ResasKit::Response::RaiseError::CODE_ERRORS[status_code].name.demodulize
  end

  subject { -> { response.on_complete(faraday_env_mock) } }
  it { is_expected.to raise_error(ResasKit::Error, "#{error_class_name} - This is an error message. (STATUS CODE: #{status_code}) (DESCRIPTION: This is an error description.)") }
end
