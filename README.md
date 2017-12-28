# BuriAuth

In each project, authentication is almost always required and Devise is almost always the go-to gem to implement such 
functionality. While Devise is easy to use and configure, its codebase lives in the core of the application and often needs 
tinkering. So this `gem` is modular approach to provide a ready-to-use authentication in any Ruby on Rails application. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'buriauth'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install buriauth
```

## Usage

* Mounted into the host application:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount BuriAuth::Engine, at: '/'

  root 'dashboard#index'
end
```

## License

This project is Copyright (c) 2014-2017 Nimbl3 Ltd. It is free software,
and may be redistributed under the terms specified the [LICENSE] file.

## About

![Nimbl3](https://dtvm7z6brak4y.cloudfront.net/logo/logo-repo-readme.jpg)

This project is maintained and funded by Nimbl3 Ltd.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimbl3
[hire]: https://nimbl3.com/
