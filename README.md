# PS-Commitzen-Setup

A PowerShell script to simplify the installation of [Scoop](https://scoop.sh/), [Python](https://www.python.org/), [pipx](https://pipxproject.github.io/pipx/), and [Commitizen](https://commitizen.github.io/cz-cli/) for managing commits in projects.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)

## Overview

This repository contains a PowerShell script called `ps-commitzen-script.ps1`, which automates the setup of the development environment with useful tools for managing commits.

## Features

- Installs Scoop, a package manager for Windows.
- Installs Python and pipx, allowing the installation of Python applications in isolation.
- Installs Commitizen to facilitate the standardization of commit messages (default).

## Requirements

- Windows 10 or higher.
- PowerShell 5.1 or higher.
- Internet access for downloads.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/strFelix/PS-Commitzen-Setup.git

2. Installation: <br>
   Run `setup.exe` in the root of the repository.

## Usage

After running the script, you will have Scoop, Python, pipx, and Commitizen installed and ready to use. <br>
To verify that everything was installed correctly, execute the following commands in PowerShell:

```powershell
scoop --version
python --version
pipx --version
cz -version
