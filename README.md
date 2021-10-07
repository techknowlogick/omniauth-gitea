![Ruby](https://github.com/techknowlogick/omniauth-gitea/workflows/Ruby/badge.svg?branch=main)

# OmniAuth Gitea

This is an OmniAuth strategy for authenticating to Gitea. To
use it, you'll need to create an [OAuth2 Application ID and Secret](https://docs.gitea.io/en-us/oauth2-provider/#example).

## Installation

```ruby
gem 'omniauth-gitea', github: 'techknowlogick/omniauth-gitea', branch: 'main'
```

## Basic Usage

```ruby
use OmniAuth::Builder do
  provider :gitea, ENV['GITEA_KEY'], ENV['GITEA_SECRET']
end
```

## Basic Usage Rails

In `config/initializers/gitea.rb`

```ruby
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :gitea, ENV['GITEA_KEY'], ENV['GITEA_SECRET']
  end
```

## Codeberg/Self-Hosted Usage

```ruby
provider :gitea, ENV['GITEA_KEY'], ENV['GITEA_SECRET']
    {
      :client_options => {
        :site => 'https://codeberg.org',
        :authorize_url => 'https://codeberg.org/login/oauth/authorize',
        :token_url => 'https://codeberg.org/login/oauth/access_token'
      }
    }
```
Or if you are hosting Gitea using a sub-path of your domain
```ruby
provider :gitea, ENV['GITEA_KEY'], ENV['GITEA_SECRET']
    {
      :client_options => {
        :site => 'https://YOURDOMAIN.com/gitea',
        :authorize_url => 'https://YOURDOMAIN.com/login/oauth/authorize',
        :token_url => 'https://YOURDOMAIN.com/login/oauth/access_token'
      }
    }
```

## License

This project is forked from [omniauth-github](https://github.com/omniauth/omniauth-github), and thus retains the same license. We are all standing on the shoulders of giants.

Copyright (c) 2011 Michael Bleigh and Intridea, Inc.
Copyright (c) 2021 TechKnowLogick

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
