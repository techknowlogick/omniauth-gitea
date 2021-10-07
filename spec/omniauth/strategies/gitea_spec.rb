require 'spec_helper'

describe OmniAuth::Strategies::Gitea do
  let(:access_token) { instance_double('AccessToken', :options => {}, :[] => 'user') }
  let(:parsed_response) { instance_double('ParsedResponse') }
  let(:response) { instance_double('Response', :parsed => parsed_response) }

  let(:selfhosted_site)          { 'https://some.other.site.com' }
  let(:selfhosted_authorize_url) { 'https://some.other.site.com/login/oauth/authorize' }
  let(:selfhosted_token_url)     { 'https://some.other.site.com/login/oauth/access_token' }
  let(:selfhosted) do
    OmniAuth::Strategies::Gitea.new('GITEA_KEY', 'GITEA_SECRET',
        {
            :client_options => {
                :site => selfhosted_site,
                :authorize_url => selfhosted_authorize_url,
                :token_url => selfhosted_token_url
            }
        }
    )
  end

  subject do
    OmniAuth::Strategies::Gitea.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context 'client options' do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://gitea.com')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://gitea.com/login/oauth/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('https://gitea.com/login/oauth/access_token')
    end

    describe 'should be overrideable' do
      it 'for site' do
        expect(selfhosted.options.client_options.site).to eq(selfhosted_site)
      end

      it 'for authorize url' do
        expect(selfhosted.options.client_options.authorize_url).to eq(selfhosted_authorize_url)
      end

      it 'for token url' do
        expect(selfhosted.options.client_options.token_url).to eq(selfhosted_token_url)
      end
    end
  end

  context '#raw_info' do
    it 'should use relative paths' do
      expect(access_token).to receive(:get).with('api/v1/user').and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end

    it 'should use the header auth mode' do
      expect(access_token).to receive(:get).with('api/v1/user').and_return(response)
      subject.raw_info
      expect(access_token.options[:mode]).to eq(:header)
    end
  end

  describe '#callback_url' do
    it 'is a combination of host, script name, and callback path' do
      allow(subject).to receive(:full_host).and_return('https://example.com')
      allow(subject).to receive(:script_name).and_return('/sub_uri')

      expect(subject.callback_url).to eq('https://example.com/sub_uri/auth/gitea/callback')
    end
  end
end
