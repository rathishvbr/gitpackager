module MegamPkg
  class Ger
  CONFIG =  {:os => ['trusty', 'precise'],
        :designer_name => "megamdesigner"}

  if !Gem::Specification::find_all_by_name('pkgr').any?
      puts "gem install pkgr"
      system 'gem install pkgr'
  end

  end
end
