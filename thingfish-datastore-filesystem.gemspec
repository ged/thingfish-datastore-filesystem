# -*- encoding: utf-8 -*-
# stub: thingfish-datastore-filesystem 0.0.1.pre20161103180658 ruby lib

Gem::Specification.new do |s|
  s.name = "thingfish-datastore-filesystem"
  s.version = "0.0.1.pre20161103180658"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Michael Granger", "Mahlon E. Smith"]
  s.cert_chain = ["/Users/ged/.gem/gem-public_cert.pem"]
  s.date = "2016-11-04"
  s.description = "This is a data storage plugin for the Thingfish digital asset manager.\nIt provides persistent storage for uploaded data to a simple filesystem\npath."
  s.email = ["ged@FaerieMUD.org", "mahlon@martini.nu"]
  s.extra_rdoc_files = ["History.rdoc", "LICENSE.rdoc", "Manifest.txt", "README.rdoc", "History.rdoc", "LICENSE.rdoc", "README.rdoc"]
  s.files = [".document", ".simplecov", "ChangeLog", "History.rdoc", "LICENSE.rdoc", "Manifest.txt", "README.rdoc", "Rakefile", "lib/thingfish/datastore/filesystem.rb", "spec/helpers.rb", "spec/thingfish/datastore/filesystem_spec.rb"]
  s.homepage = "http://bitbucket.org/ged/thingfish-datastore-filesystem"
  s.licenses = ["BSD"]
  s.rdoc_options = ["-f", "fivefish", "-t", "Thingfish-Datastore-FileSystem"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.5.1"
  s.summary = "This is a data storage plugin for the Thingfish digital asset manager"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thingfish>, ["~> 0.5"])
      s.add_runtime_dependency(%q<configurability>, ["~> 2.2"])
      s.add_development_dependency(%q<hoe-mercurial>, ["~> 1.4"])
      s.add_development_dependency(%q<hoe-deveiate>, ["~> 0.8"])
      s.add_development_dependency(%q<hoe-highline>, ["~> 0.2"])
      s.add_development_dependency(%q<rspec>, ["~> 3.1"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.9"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.15"])
    else
      s.add_dependency(%q<thingfish>, ["~> 0.5"])
      s.add_dependency(%q<configurability>, ["~> 2.2"])
      s.add_dependency(%q<hoe-mercurial>, ["~> 1.4"])
      s.add_dependency(%q<hoe-deveiate>, ["~> 0.8"])
      s.add_dependency(%q<hoe-highline>, ["~> 0.2"])
      s.add_dependency(%q<rspec>, ["~> 3.1"])
      s.add_dependency(%q<simplecov>, ["~> 0.9"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<hoe>, ["~> 3.15"])
    end
  else
    s.add_dependency(%q<thingfish>, ["~> 0.5"])
    s.add_dependency(%q<configurability>, ["~> 2.2"])
    s.add_dependency(%q<hoe-mercurial>, ["~> 1.4"])
    s.add_dependency(%q<hoe-deveiate>, ["~> 0.8"])
    s.add_dependency(%q<hoe-highline>, ["~> 0.2"])
    s.add_dependency(%q<rspec>, ["~> 3.1"])
    s.add_dependency(%q<simplecov>, ["~> 0.9"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<hoe>, ["~> 3.15"])
  end
end
