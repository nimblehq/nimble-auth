<p align="center">
    <strong>Nimble Auth - Modern ready-to-use auhentication engine</strong>
</p>

<p align="center">
    <a href='https://semaphoreci.com/nimblehq/nimble-auth'> <img src='https://semaphoreci.com/api/v1/nimblehq/nimble-auth/branches/development/badge.svg' alt='Build Status'></a>
</p>

---

In each project, authentication is almost always required and Devise is almost always the go-to gem to implement such 
functionality. While Devise is easy to use and configure, its codebase lives in the core of the application and often needs 
tinkering. So this `gem` is a modular approach to provide a ready-to-use authentication module in any Ruby on Rails application. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nimble-auth'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install nimble-auth
```

## Usage

* Setup Nimble Auth
```
rails generate nimble_auth:install
rake db:migrate
```

## License

This project is Copyright (c) 2014-2019 Nimble. It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
