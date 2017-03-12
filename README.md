# Extended Ruby Classes

This gem extents some of the basic Ruby classes by missing functionalities.

## Install

The preferred method of installation is via RubyGems.org:  
<https://rubygems.org/gems/thefox-ext>

	gem install thefox-ext

or via `Gemfile`:

	gem 'thefox-ext', '~>1.5'

Use it in your sources:

	require 'thefox-ext'

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
- [Travis CI Repository](https://travis-ci.org/TheFox/ext.rb)

## License

Copyright (C) 2015 Christian Mayer <https://fox21.at>

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
