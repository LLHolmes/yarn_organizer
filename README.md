# YarnOrganizer

FlatIron School - Sinatra Final Project

Welcome to Yarn Organizer, a Sinatra application designed to help you wrangle your yarn stash and crafty projects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yarn_organizer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yarn_organizer

## Usage

Add yarn to your virtual stash to track what yarn you have available for your crafting projects.  Upon joining, you will automatically be given a "Stash" project and be taken a page where you can add multiple yarns at once to stock your stash.  Your "Stash" will be your default project where all yarns will be added unless you specify a project.  If you have an account and log in, you will be taken to your Home page that displays all your Projects, Yarn, and Tools.

At the top of all pages you will find quick access to your Home, My Projects, My Yarn, and My Tools indexes, along with links to add a New Project, New Tool, New Yarn, or add Many New Yarns (which will take you back to the stock your stash page you were first taken to when you joined).  You can visit Account Details if you want to change your password or delete your account. Log Out will end your session.

On each index page (My Projects, My Yarn, and My Tools) you can visit an individual item and can choose to update it or delete it.  If you delete a Project, all associated yarn and tools will be added to your "Stash".  If you finish a project, you will be taken to a secondary page where you should update the amount of yarn you have remaining after completing your project so your stash will be up to date.  When finishing a project, all yarn and tools will be added back into your "Stash".

Have fun!

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/<github username>/yarn_organizer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the YarnOrganizer project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/<github username>/yarn_organizer/blob/master/CODE_OF_CONDUCT.md).
