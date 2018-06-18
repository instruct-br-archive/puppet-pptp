[![Build Status](https://travis-ci.org/instruct-br/puppet-pptp.svg?branch=master)](https://travis-ci.org/instruct-br/puppet-pptp) ![License](https://img.shields.io/badge/license-Apache%202-blue.svg) ![Version](https://img.shields.io/puppetforge/v/instruct/puppetagent.svg) ![Downloads](https://img.shields.io/puppetforge/dt/instruct/puppetagent.svg)

# pptp

#### Table of contents

1. [Overview](#overview)
1. [Supported Platforms](#supported-platforms)
1. [Requirements](#requirements)
1. [Installation](#installation)
1. [Usage](#usage)
1. [References](#references)
1. [Development](#development)

## Overview

This module will manage pptp in your system.

This is a very simple module, usually used for development and test purposes.

Yes, you can use it in production, but it is a simple module, you may miss some parameters for production use.

The main objective is to manage pptp with minimal intervention in the default files.

## Supported Platforms

This module was tested under these platforms

- RedHat 7
- CentOS 7
- Scientific  7
- Oracle Linux 7

Tested only in x86_64 arch.  

## Requirements

### Pre-Reqs

You need internet to install packages.

### Requirements

- Puppet >= 5.x
  - Hiera >= 3.4
  - Facter >= 2.5

## Installation

Via git:

    # cd /etc/puppetlabs/code/environment/production/modules
    # git clone https://github.com/instruct-br/puppet-pptp.git pptp

Via puppet:

    # puppet module install instruct/pptp

Via `puppetfile`:

    mod 'instruct-pptp'

## Usage

### Quick run

    puppet apply -e "include pptp"

### Using with parameters

#### Example in EL 7

```puppet
class { 'pptp':
  package_name    = 'pptp',
  package_manage  = true,
  module_manage   = true,
  firewall_manage = false,
  Array[
    Struct[
      {
        name     => String,
        ip       => String,
        route    => String,
        username => String,
        password => String,
        running  => Boolean,
        enable   => Boolean,
      }
    ]
  ]                                                             $connections     = [],
  package_ensure  = 'latest',
}
```

## References

### Classes

```puppet
pptp
pptp::install (private)
pptp::service (private)
pptp::connections (private)
```

### Parameters type

#### `package_name`

Type: String

The name of the package to install

#### `package_manage`

Type: Boolean

Should the package be managed or not. Default to true.

#### `module_manage`

Type: Boolean

Should the kernel module be managed or not. Default to true.

#### `firewall_manage`

Type: Boolean

Should the firewall rule be managed or not. Default to true.

#### `connections`

Type: Array

List of connections to be configured. Default to empty list.

#### `package_ensure`

Type: Enum['present','installed','absent','purged','held','latest']

The type of ensure the managed package should be enforced. Default to latest.

### Hiera Keys Sample

```yaml
---
pptp::package_name: 'pptp'
pptp::package_manage: true
pptp::package_ensure: installed
pptp::module_manage: true
pptp::firewall_manage: true
```

### Hiera module config

This is the Hiera v5 configuration inside the module.

This module does not have params class, everything is under hiera v5.

```yaml
---
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: "OSes"
    paths:
     - "oses/distro/%{facts.os.name}/%{facts.os.release.major}.yaml"
     - "oses/family/%{facts.os.family}.yaml"

  - name: "common"
    path: "common.yaml"

```

This is an example of files under modules/pptp/data

```
oses/family/RedHat.yaml
oses/distro/CentOS/7.yaml
oses/distro/Scientific/7.yaml
oses/distro/OracleLinux/7.yaml
```

## Development

### My dev environment

This module was developed using

- Puppet 5.5.3
  - Hiera 3.4.3 (v5 format)
  - Facter 3.11.1
- CentOS 7.5
- VirtualBox 5.2.12
- Vagrant 2.1.1

### Testing

This module uses puppet-lint, puppet-syntax, metadata-json-lint, rspec-puppet, beaker and travis-ci. We hope you use them before submitting your PR.

#### Installing gems

    gem install bundler --no-document
    bundle install --without development

#### Running syntax tests

    bundle exec rake syntax
    bundle exec rake lint
    bundle exec rake metadata_lint

#### Running unit tests

    bundle exec rake spec

### Author

Taciano Tres (taciano at instruct dot com dot br)

### Contributors
