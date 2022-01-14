# Erbcop

[![Gem Version](https://badge.fury.io/rb/erbcop.svg)](https://rubygems.org/gems/erbcop)
[![test](https://github.com/r7kamura/erbcop/actions/workflows/test.yml/badge.svg)](https://github.com/r7kamura/erbcop/actions/workflows/test.yml)

[RuboCop](https://github.com/rubocop/rubocop) runner for ERB template.

This is the ERB version of [Slimcop](https://github.com/r7kamura/slimcop).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'erbcop'
```

And then execute:

```
bundle install
```

Or install it yourself as:

```
gem install erbcop
```

## Usage

Use `erbcop` executable to check offenses and auto-correct them.

```console
$ erbcop --help
Usage: erbcop [options] [file1, file2, ...]
    -a, --auto-correct               Auto-correct offenses.
    -c, --config=                    Specify configuration file. (default: .erbcop.yml or .rubocop.yml)
        --[no-]color                 Force color output on or off.
```

### Example

```console
$ erbcop 'spec/fixtures/**/*.erb'
Inspecting 1 file
C

Offenses:

spec/fixtures/dummy.erb:1:4: C: [Correctable] Style/StringLiterals: Prefer single-quoted strings when you don't need string interpolation or special symbols.
<% "a" %>
   ^^^
spec/fixtures/dummy.erb:4:9: C: [Correctable] Style/NumericPredicate: Use array.size.positive? instead of array.size > 0.
<% a if array.size > 0 %>
        ^^^^^^^^^^^^^^
spec/fixtures/dummy.erb:4:9: C: [Correctable] Style/ZeroLengthPredicate: Use !empty? instead of size > 0.
<% a if array.size > 0 %>
        ^^^^^^^^^^^^^^
spec/fixtures/dummy.erb:5:4: C: [Correctable] Style/NegatedIf: Favor unless over if for negative conditions.
<% a if !b %>
   ^^^^^^^

1 file inspected, 4 offenses detected, 4 offenses auto-correctable
```
