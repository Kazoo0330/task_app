# -*- encoding: utf-8 -*-
# stub: enum 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "enum".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["capnregex".freeze]
  s.date = "2010-09-14"
  s.description = "A java like Enum class for ruby. \n\nA while ago I was exploring Java, and came across the Enum class, which had\nsome interesting functionality, and I decided that I would like something like\nit. \n\nConceptually if you just need a unique identifier you may be perfectly happy using a :symbol, and that would likely be a simpler way of having a controll flag. However, if you want to have a set of unique identifiers that you can address, iterate over, assign properties to, etc, then this may be something you would be interested in.".freeze
  s.email = ["capnregex@gmail.com".freeze]
  s.extra_rdoc_files = ["History.txt".freeze, "Manifest.txt".freeze, "README.txt".freeze]
  s.files = ["History.txt".freeze, "Manifest.txt".freeze, "README.txt".freeze]
  s.homepage = "http://github.com/capnregex/enum".freeze
  s.rdoc_options = ["--main".freeze, "README.txt".freeze]
  s.rubyforge_project = "enum".freeze
  s.rubygems_version = "2.6.11".freeze
  s.summary = "A java like Enum class for ruby".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rubyforge>.freeze, [">= 2.0.4"])
      s.add_development_dependency(%q<hoe>.freeze, [">= 2.6.2"])
    else
      s.add_dependency(%q<rubyforge>.freeze, [">= 2.0.4"])
      s.add_dependency(%q<hoe>.freeze, [">= 2.6.2"])
    end
  else
    s.add_dependency(%q<rubyforge>.freeze, [">= 2.0.4"])
    s.add_dependency(%q<hoe>.freeze, [">= 2.6.2"])
  end
end
