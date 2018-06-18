require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'metadata-json-lint/rake_task'
require 'puppet-syntax/tasks/puppet-syntax'

PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.send('relative')

task :integration => [:syntax, :lint, :metadata_lint, :spec]
