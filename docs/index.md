---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: home
title: WhatsApp Dark Mode Switcher
---

[![Build Status](https://travis-ci.com/marchrius/wa-dark-mode-switcher.svg?branch=master)](https://travis-ci.com/marchrius/wa-dark-mode-switcher)
[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo=marchrius/wa-dark-mode-switcher)](https://dependabot.com)
[![Known Vulnerabilities](https://snyk.io/test/github/marchrius/wa-dark-mode-switcher/badge.svg?targetFile=/docs/Gemfile.lock)](https://snyk.io/test/github/marchrius/wa-dark-mode-switcher?targetFile=/docs/Gemfile.lock)

-   [Purpose](#purpose)
-   [Screenshot](#screenshot)
-   [Notice](#notice)
-   [Usage](#usage)
    -   [For All Systems/OS](#for-all-systems-os)
    -   [For macOS and Linux](#for-macos-and-linux)
    -   [For Windows Users](#for-windows-users)
    -   [Dark Mode Toggle](#dark-mode-toggle)
-   [Attributions](#attributions)
-   [Bugs](#bugs)
-   [License](#license)
-   [Donate](#donate)

## Purpose

Add a shortcut to switch between light and dark theme.
This script does not add or enhance native Dark Mode.

The following platforms are supported in this repo via scripts:

-   macOS [wa-dark-mode-switcher.sh](wa-dark-mode-switcher.s)
-   Linux [wa-dark-mode-switcher.sh](wa-dark-mode-switcher.sh)
-   Windows [wa-dark-mode-switcher.ps1](wa-dark-mode-switcher.ps1)

On macOS and Linux if a PowerShell Core is installed (v6.x and above) the wa-dark-mode-switcher.ps1 script can be used0

## Screenshot

![Screenshot](https://github.com/marchrius/wa-dark-mode-switcher/raw/master/images/screenshot.png "Screenshot")

## Notice

Make always a backup of your application.

## Usage

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/e88f5c76dfdf418e9c2571943437ae23)](https://www.codacy.com/app/Lanik/wa-dark-mode-switcher?utm_source=github.com&utm_medium=referral&utm_content=marchrius/wa-dark-mode-switcher&utm_campaign=Badge_Grade)
[![codecov](https://codecov.io/gh/marchrius/wa-dark-mode-switcher/branch/master/graph/badge.svg)](https://codecov.io/gh/marchrius/wa-dark-mode-switcher)

### For All Systems/OS

First, clone the repository

```bash
git clone https://github.com/marchrius/wa-dark-mode-switcher
cd wa-dark-mode-switcher
```

Then shutdown WhatsApp and please reference for your operating system:

### For macOS and Linux

```bash
./wa-dark-mode-switcher.sh
```

or if PowerShell Core (v6.x or above) is installed

Note: This script will automatically kill WhatsApp each time you update.

```powershell
./wa-dark-mode-switcher.ps1
```

### For Windows Users

Open Powershell in Admin mode:  
Note: This script will automatically kill WhatsApp each time you update.

```powershell
.\wa-dark-mode-switcher.ps1
```

### Dark Mode Toggle

To toggle Dark Mode on or off you can use Ctrl + L (lower case) on any OS.

## Attributions

Scripts was "borrowed" from [LanikSJ](https://github.com/LanikSJ) [Gist](https://github.com/LanikSJ/wa-dark-mode-switcher)
©️ All rights reserved by the original authors.

## Bugs

Please report any bugs or issues you find. Thanks!

## License

[![GPLv3 License](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)

## Donate

[![Patreon](https://img.shields.io/badge/patreon-donate-red.svg)](https://www.patreon.com/marchrius/overview)
[![PayPal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.me/marchrius)
