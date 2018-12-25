# Nonsensor

Generate streams of random data that look good on charts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nonsensor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nonsensor

## Usage

Note: this gem is experimental and it's guaranteed that the public API will change with each commit. For now.

Currently there are 3 classes of interest `Nonsensor::DateSeries`, `Nonsensor::MidpointDisplacement`, `Nonsensor::Sensor`.

The first two are used to generate new values each time the `next!` method is called. While `Sensor` can be used to combine them.

Example:

```
date = Nonsensor::DateSeries.new(start: Date.new(2018, 10, 10))
date.take!(3).map(&:to_s)
# => ["2018-10-10", "2018-10-10", "2018-10-10"]

temperature = Nonsensor::MidpointDisplacement.new(start: 25, displacement: 5)
temperature.take!(3).map(&:to_s)
# => ["25", "25.215588830195678", "25.137908924728947"]

pressure = Nonsensor::MidpointDisplacement.new(start: 1000, displacement: 25)
pressure.take!(3).map(&:to_s)
# => ["1000", "1002.3275690365925", "1002.1710234288906"]

sensor = Nonsensor::Sensor.new({ date: date, temperature: temperature, pressure: pressure })

puts sensor.take!(10).map { |v| "date: #{v[:date]}, temperature: #{v[:temperature].round(2)}C, pressure: #{v[:pressure].round}hPa" }
# date: 2018-10-13, temperature: 25.32C, pressure: 999hPa
# date: 2018-10-14, temperature: 25.43C, pressure: 999hPa
# date: 2018-10-15, temperature: 25.54C, pressure: 998hPa
# date: 2018-10-16, temperature: 25.77C, pressure: 998hPa
# date: 2018-10-17, temperature: 25.95C, pressure: 1000hPa
# date: 2018-10-18, temperature: 26.11C, pressure: 1000hPa
# date: 2018-10-19, temperature: 26.41C, pressure: 1000hPa
# date: 2018-10-20, temperature: 26.96C, pressure: 1000hPa
# date: 2018-10-21, temperature: 27.04C, pressure: 1000hPa
# date: 2018-10-22, temperature: 27.21C, pressure: 1000hPa
```

- `next!` with a bang, because each call will change state of the instance
- `take(10)` without a bang will return a lazy enumerator
- `take!(10)` with a bang will return an array, but be careful because there's an infinite loop underneath

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/musialik/nonsensor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Nonsensor project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/musialik/nonsensor/blob/master/CODE_OF_CONDUCT.md).
