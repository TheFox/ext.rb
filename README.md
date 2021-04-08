# Extended Ruby Classes

This gem extents some of the basic Ruby classes by missing functionalities.

## Project Outlines

The project outlines as described in my blog post about [Open Source Software Collaboration](https://blog.fox21.at/2019/02/21/open-source-software-collaboration.html).

- The main purpose of this collection is to provide common single functions or classes, which are too small for a separate project.
- This list is open. Feel free to request features.

## Install

The preferred method of installation is via RubyGems.org:
<https://rubygems.org/gems/thefox-ext>

```bash
gem install thefox-ext
```

or via `Gemfile`:

```ruby
gem 'thefox-ext', '~>1.10'
```

Use it in your sources:

```ruby
require 'thefox-ext'
```

## Features

- [String Manipulation](lib/thefox-ext/ext/string.rb)
	- Title Case
	- UTF-8 Encoding
	- Intenger 32-bit Array
- Console Support
- Date
	- `today?`
	- Get week array for a specific date.
- Hash
	- Recursive Merge
- Range String Resolver

## Project Links

- [Gem](https://rubygems.org/gems/thefox-ext)
