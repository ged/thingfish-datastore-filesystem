# -*- encoding: utf-8 -*-
# stub: thingfish-datastore-filesystem 0.3.0.pre.20200407173235 ruby lib

Gem::Specification.new do |s|
  s.name = "thingfish-datastore-filesystem".freeze
  s.version = "0.3.0.pre.20200407173235"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://todo.sr.ht/~ged/Thingfish-Datastore-Filesystem/browse", "documentation_uri" => "http://deveiate.org/code/Thingfish-Datastore-Filesystem", "homepage_uri" => "https://hg.sr.ht/~ged/Thingfish-Datastore-Filesystem", "source_uri" => "https://hg.sr.ht/~ged/Thingfish-Datastore-Filesystem/browse" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.date = "2020-04-07"
  s.description = "This is a data storage plugin for the Thingfish digital asset manager. It provides persistent storage for uploaded data to a simple filesystem path.".freeze
  s.files = [".document".freeze, ".simplecov".freeze, "History.rdoc".freeze, "LICENSE.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "Rakefile".freeze, "lib/thingfish/datastore/filesystem.rb".freeze, "spec/helpers.rb".freeze, "spec/thingfish/datastore/filesystem_spec.rb".freeze]
  s.homepage = "https://hg.sr.ht/~ged/Thingfish-Datastore-Filesystem".freeze
  s.licenses = ["BSD-3-Clause".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "This is a data storage plugin for the Thingfish digital asset manager.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<configurability>.freeze, ["~> 4.1"])
      s.add_runtime_dependency(%q<thingfish>.freeze, ["~> 0.7"])
      s.add_development_dependency(%q<fakefs>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.8"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.12"])
    else
      s.add_dependency(%q<configurability>.freeze, ["~> 4.1"])
      s.add_dependency(%q<thingfish>.freeze, ["~> 0.7"])
      s.add_dependency(%q<fakefs>.freeze, ["~> 1.2"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.12"])
    end
  else
    s.add_dependency(%q<configurability>.freeze, ["~> 4.1"])
    s.add_dependency(%q<thingfish>.freeze, ["~> 0.7"])
    s.add_dependency(%q<fakefs>.freeze, ["~> 1.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.12"])
  end
end
