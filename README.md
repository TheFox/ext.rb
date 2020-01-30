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
gem 'thefox-ext', '~>1.5'
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
- Array
	- Range String Resolver
- Hash
	- Recursive Merge

## Project Links

- [Gem](https://rubygems.org/gems/thefox-ext)

## License

Copyright (C) 2015 Christian Mayer <https://fox21.at>

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
