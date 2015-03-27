# MRZ

Generate your passport machine readable zone

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mrz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mrz

## Usage

```ruby
params = {
  country: '',
  first_name: 'Anthony',
  middle_name: 'Vincent',
  last_name: 'Laibe', 
  passport_number: 9881234, 
  nationality: '',
  date_of_birth: '10/10/1889', 
  gender: 'm', 
  expiration_date: '10/12/2025', 
  personal_number: 1234, 
}

Mrz::Builder.new(params).generate
```

For gender the allowed values are 'm' or 'f'
The personal number is an optional parameter
This method return an array of size 2, each entry correspond to a line of the MRZ

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mrz/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
