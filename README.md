# Zikaron

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'zikaron'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zikaron

## Usage

Create config/zikaron.rb:

    Zikaron.configuration do |config|
      config.redis_url = "http://foo.bar.bat.baz.com/"
      config.memory_duration = 50 #seconds
      config.cache_name = :my_application_name
    end

Then, in your controller:

    class MyController < ApplicationController

      include Zikaron::Remembers::Actions

      remember :show

      def show
        render :text => @memory.to_s
      end

    end
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
