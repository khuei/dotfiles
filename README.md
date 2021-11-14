## Dotfiles

> Stay in \*nixland, and I'll show you how deep the rabbit hole goes

## Installation

run the following command to run install script:

``` sh
$ ./install
```

given that `~/.gitconfig` is included with these dotfiles, any local
configurations should be written to `~/.gitconfig.local` instead, such as:

``` sh
$ git config --file ~/.gitconfig.local user.name  "John Doe"
$ git config --file ~/.gitconfig.local user.email "johndoe@example.com"
```
