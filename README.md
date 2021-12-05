# guard::codespell

**guard-codespell** helps keeping your code typo free by running [codespell](https://github.com/codespell-project/codespell) when files are modified

## Installation

Please make sure to have [Guard](https://github.com/guard/guard) and [codespell](https://github.com/codespell-project/codespell) installed before you start.

Add `guard-codespell` to your `Gemfile`.

```ruby
group :development do
  gem 'guard-codespell'
end
```

and then execute:

```sh
$ bundle install
```
## Usage

See guard documentation for how to [add a guard plugin](https://github.com/guard/guard#add-guard-plugins) and [how to use guard](https://github.com/guard/guard#usage).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hooktstudios/guard-codespell. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/hooktstudios/guard-codespell/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Guard::Codespell project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hooktstudios/guard-codespell/blob/master/CODE_OF_CONDUCT.md).
