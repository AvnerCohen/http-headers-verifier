# Http Headers Verifier

Verify a pre-defined HTTP headers configurations.
Unlike some other similar projects, this is not meant to enforce best practices, instead it is meant to define policies on top of headers and enforce them.
As a side effect, this means you can define specific OWASP (for example) best practices and verify them, but unlike testing for best practices, this is inteneded to verify an expected headers configuration behavior.

Relevant use cases are for example when updating nginx/caddy configuration or when moving from one web-server to another and expecting to maintain a specific set of header config.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'http-headers-verifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install http-headers-verifier

### Usage

```sh
usage: http-headers-verifier [comma seperated policy names] [url] [?verbose]
```

#### Example

```sh
$> ./http-headers-verifier.rb  default,hs-default https://my.login.page/login verbose

Starting verification of policies default, hs-default, hs-production:
	🍏 Expected Header 'Cache-Control' matched!
	🍏 Expected Header 'Content-Type' matched!
	🍏 Expected Header 'Vary' matched!
	🍏 Expected Header 'Content-Security-Policy' matched!
	🍏 Expected Header 'Expires' matched!
	🍏 Expected Header 'X-Frame-Options' matched!
	🍏 Expected Header 'X-XSS-Protection' matched!
	🍏 Expected Header 'X-Content-Type-Options' matched!
	🍏 Expected Header 'X-Whoami' matched!
	🍏 Expected Header 'Strict-Transport-Security' matched!
	🍏 Extra Header 'date' marked for ignore!
	🍏 Extra Header 'content-length' marked for ignore!
	🍏 Cookie 'AWSALB' passed verification!
	🍏 Cookie 'AWSALBCORS' passed verification!
	🍏 Cookie 'session' passed verification!
😎  Success !
```

Or in non-verbose mode:

```sh
$>./http-headers-verifier.rb  default,hs-default https://my.login.page/loginlogin
Starting verification of policies default, hs-default, hs-production:
	🛑 Invalid cookie config 'COOKIE_NAME':
 		👺   Cookie not secure.
😱  Failed !
```


### Configuration

Policy configuration is a series of YAML files, with the following naming convention:
`headers-rules-*.yml`

Where \* is the policy named to be used in the command line.

Configuration has the following YMAL blockes:

```yaml
---
    headers:

    cookie_attr:

    ignored_headers:

    headers_to_avoid:

```

[Example](headers-rules-example.yml)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AvnerCohen/http-headers-verifier. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Http::Headers::Verifier project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/http-headers-verifier/blob/master/CODE_OF_CONDUCT.md).
