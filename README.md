# RadCommon
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rad_common'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rad_common
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Development

### Point Projects to Local Source Instead of Github

When refactoring and modifying code in this project while developing other projects, you may want your other project to point to the local source rather than the remote on Github. In your client project, you still need to keep the Gemfile pointing to the Github location but you can override your bundler setting like as follows:

`bundle config local.rad_common /Users/garyfoster/Documents/Projects/rad_common`

to undo this and revert to the remote github repository:

`bundle config --delete local.rad_common`
