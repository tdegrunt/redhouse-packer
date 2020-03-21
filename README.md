# Introduction

This repository contains the [Packer](https://www.packer.io/) template used
for building the [Vagrant](https://www.vagrantup.com/) base box that is used
by [Redhouse](https://github.com/mrkcor/redhouse) (a Vagrant box setup for
developing Ruby applications).

The scripts and setup are based on those from the
[Chef Bento](https://github.com/chef/bento) and
[Laravel Settler](https://github.com/laravel/settler) projects, thank you
to all who have contributed to those projects to make the lives of many
developers so much easier!

Build the box with:
```
packer build ./ubuntu-18.04-amd64.json
```

Once the box is built you can do the following to add it to vagrant:
```
vagrant box add --name redhouse ./builds/redhouse.virtualbox.box
```


For more information checkout out https://github.com/mrkcor/redhouse

