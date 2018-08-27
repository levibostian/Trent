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