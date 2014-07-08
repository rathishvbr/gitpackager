module MegamPkg
  class Ger
  CONFIG =  {:os => ['trusty', 'precise'],
        :name => "megamnilavu"}

  if !Gem::Specification::find_all_by_name('pkgr').any?
      puts "gem install pkgr"
      system 'gem install pkgr'
  end

  end
end
