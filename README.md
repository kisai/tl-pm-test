# Project tl-pm-test

## Description

A brief description of your project.

## Installation

1. Clone the repository.
2. Install the dependencies by running the following command:

    ```shell
    bundle install
    ```

## Usage

### Running Tests

To run the tests located in the `spec` directory, use the following command:

```shell
bundle exec rspec
```

### Running scripts

## Maximum temperature spread

```shell
bundle exec ruby bin/temperature_spread.rb data/w_data.dat
```

## Smallest difference for/against goals

```shell
bundle exec ruby bin/goals_difference.rb data/soccer.dat
```

### Structure of the project

### Rationale

In my experience in the banking industry in Mexico processing files like these, plain tables without a specific format like CSV, the best approach is to use position for the columns. Ruby give us a simple syntax to do this by slicing strings, and converting to integer is easy with the standard String#to_i method.

In multiple projects, like in the banking, real-estate industries, I have found that is easier to maintain background jobs and track errors following simple scripts, rather than having multiple levels of object orientation and modeling.

```ruby
line[0..2].to_i
```

Using a different approach like a line parser, for instance using the StringScanner class, or simply using String#split method would be problematic because of empty values in some columns per lines, this is why using column ranges is the best option.
