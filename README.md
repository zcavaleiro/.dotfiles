# dotfiles-example
This repository contains a quick demo for setting up a Linux operating system with 3 different ways to install applications. It also contains an example of my dotfiles configuration.

The operating system used for testing was *Fedora 41*. It can be easily adapted to other linux distributions from the Red Hat family. 

## why

- When we need to install and configure an Operating system several times, on multiples machines, and keep them identical.. lots of manual, and repeated work needs to be done.
- This demonstration, addresses that problem.
- It can help to configure different devices (ie, laptop, desktop, minipc), and keep consistency of applications and configuration states.


### Operating system setup files
```sh
setup_fedora.sh

# and

setup_fedora_full.sh


# Place or file, to add, delete or change apps:

fedora_apps.json
```
  - `setup_fedora.sh` 
    - applies some basics OS configurations normaly done after a fresh OS instalation (can be improved) and installs applications defined in `fedora_apps.json`.
    - does not contain or apply the setup of my dotfiles.
  - `setup_fedora_full.sh`
    - contains all the above and includes the dotfiles setup.
 

### The dotfiles

This example is based on the    

It's a [*KISS*](https://en.wikipedia.org/wiki/KISS_principle) example, Keep It Simple, Stupid!

```sh

```
