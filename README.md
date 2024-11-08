# dotfiles-example, Work in Progress..

## Intro
This repository contains a quick demo for setting up a Linux operating system with 3 different ways to install applications. It also contains an example of some dotfiles configuration.

The operating system used for testing was *Fedora 41*. It can be easily adapted to other linux distributions from the Red Hat family. 

## Why this repo?

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
   - `fedora_apps.json`
    - Its where we define the applications we need to install. It was made with 3 possibile ways to install those apps.
    - ***packages***, are the system instaled apps with `dnf`
    -  **applications**, can be compressed files like in the example.
    - **signed_packages**, contains the process of installing apps via a signed repository key by the applications proveider. In this case, Vs Code and the Brave Brower.

      ```json
      {
          "packages": [
              "dnf-plugins-core",
              "jq",
              "timeshift",
              "git",
              "kleopatra",
              "bottles"
          ],
          "applications": [
              {
                  "url": "https://developers.yubico.com/yubioath-flutter/Releases/yubico-authenticator-latest-linux.tar.gz",
                  "dir": "Yubico-authenticator"
              }
          ],
          "signed_packages": [
              "vscode",
              "brave"
          ]
      }

      ```

<br>

### The dotfiles

```sh
# the script
setup_dotfiles

# the shared dotfiles
.bashrc
.gitconfig

```

This example is based on the idea of maintaining a git repository to sync configuration files and apply then using simple [symbolic links](https://en.wikipedia.org/wiki/Symbolic_link) across multiple devices or OS's.

It's a [*KISS*](https://en.wikipedia.org/wiki/KISS_principle) example, Keep It Simple, Stupid!   

> Sharing public configuration files needs to be done with special attention. Some of those configuration files can leak personal or device sensitive information.


..

```sh

```
