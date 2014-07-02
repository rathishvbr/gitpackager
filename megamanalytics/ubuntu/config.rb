module MegamPkg
  class Ger
  CONFIG =  {:os => ['trusty', 'precise'],
        :tap_name => "megamanalytics",
        :heka_name => "megamheka"}

  if !Gem::Specification::find_all_by_name('pkgr').any?
      puts "gem install pkgr"
      system 'gem install pkgr'
  end

  end
end
