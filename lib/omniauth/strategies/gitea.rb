require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Gitea < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://gitea.com',
        :authorize_url => 'https://gitea.com/login/oauth/authorize',
        :token_url => 'https://gitea.com/login/oauth/access_token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'nickname' => raw_info['login'],
          'email' => raw_info['email'],
          'name' => raw_info['full_name'],
          'image' => raw_info['avatar_url'],
          'description' => raw_info['description'],
          'website' => raw_info['website'],
          'location' => raw_info['location'],
        }
      end

      extra do
        {:raw_info => raw_info }
      end

      def raw_info
        access_token.options[:mode] = :header
        @raw_info ||= access_token.get('api/v1/user').parsed
      end

      def callback_url
        full_host + callback_path
      end
    end
  end
end
