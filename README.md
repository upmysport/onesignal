[![Build Status](https://circleci.com/gh/upmysport/one_signal.svg?style=shield)](https://circleci.com/gh/upmysport/one_signal)
[![Dependency Status](https://gemnasium.com/upmysport/one_signal.svg)](https://gemnasium.com/upmysport/one_signal)
[![Code Climate](https://codeclimate.com/github/upmysport/one_signal/badges/gpa.svg)](https://codeclimate.com/github/upmysport/one_signal)
# OneSignal

This Gem is a Ruby wrapper for the [OneSignal API](https://documentation.onesignal.com/docs/server-api-overview) which provides Push Notification delivery and automation.

## Installation

This project hasn't been released yet. It's under development.

## Usage

To use the API client it is necessary to set the server APP_ID. You can find the APP_ID on the settings page of your app.

```ruby
OneSignal.configure do |config|
  config.app_id = 'TEST_APP_ID'
end
```

Then the client will be ready to receive method calls on the OneSignal module.

```ruby
OneSignal.add_device(device_type: 0, identifier: 'ce777617da7f548fe7a9ab6febb56')
```

Methods supported by this gem and their parameters can be found in the [API Reference](https://documentation.onesignal.com/docs/server-api-overview)


## Contributing

1. Fork it ( https://github.com/[my-github-username]/one_signal/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
