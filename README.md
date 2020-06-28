# Cinehub

Best Available Seat. Write a solution to return the best seat (closest to the front & middle) given a list of open seats. Rows follow alphabetical order with "a" being the first row. Columns follow numerical order from left to right.
The list of open seats, number of rows and columns (seats) is based on a JSON input.

## Assumptions
- The input JSON file will hold the data about the available seats only. All other seats in the venue which are all not present in seats object those will be considered as unavailable.

## Run Test Cases
To run test cases, you need to clone the repository in your system
```
$ git clone git@github.com:souvik/cinehub.git
```

Then run the setup
```
$ cd cinehub
$ bin/setup
```

Finally run all RSpec test cases
```
$ bin/rake spec
```

## Execution
To execute the program you need to setup JSON input file like "examples/sample.json" file. Then use below command run the program
```
$ ruby -Ilib exe/cinehub -f ./example/sample.json -i 2
```
Or, use below command
```
$ ruby -Ilib exe/cinehub -json-file ./example/sample.json --viewers 2
```

NOTE: Use command option '--help' to get the usage, `ruby -Ilib exe/cinehub --help`
