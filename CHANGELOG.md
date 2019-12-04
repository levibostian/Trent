### [0.5.0] 2019-12-04

### Changed 
- **Breaking change** `config_ssh` now takes in an options hash instead of password as 3rd parameter. 

### [0.4.0] 2019-03-07

### Added
- Add small set of utility functions for Travis-CI. Specifically determining if the previous branch build for a pull request was successful or not. [Discussion](https://github.com/levibostian/Trent/issues/22)

### [0.3.0] 2018-11-27

### Added
- Allow Trent to run locally. Use Trent to run scripts locally on your own machine if you wish. 

### [0.2.3] 2018-09-04

### Fixed 
- Running `sh()` commands did not allow sending anything into STDIN. 

### [0.2.2] 2018-08-27

### Fixed 
- Commenting on a GitHub pull request checks the value of `TRAVIS_PULL_REQUEST`, as there is always a value. 

### [0.2.1] 2018-08-27

### Fixed 
- `sh()` and `ssh()` did not actually use the `fail_non_success` parameter. There was a bug in the code that ended up ignoring the parameter. 

### Changed 
- When attempting to comment on a GitHub pull request and you're not on a pull request, Trent will log a warning to the console with the comment message. 

### [0.2.0] 2018-08-08

Add `path` function to Trent to perform string replacing in your commands for you. 

### Added
- Add `path` function to Trent to perform string replacing in your commands for you. 

### Changed
- Each time you run `sh()` or `ssh()` commands, your command will perform a string replace with all commands you add to `path()`. 

### [0.1.0] 2018-08-07

First release! 

### Added
- Ability to run local shell commands on Travis CI build. 
- Ability to run remote ssh commands on Travis CI builds. 
- Ability to send a comment on the GitHub pull request for the Travis CI build. 
- Trent only works with Travis-CI at this time. 