module MegamPkg
  class Ger
  CONFIG =  {:os => ['trusty', 'precise'],
	:branch => "0.7",
        :name => "megamnilavu"}

  if !Gem::Specification::find_all_by_name('pkgr').any?
      puts "gem install pkgr"
      system 'gem install pkgr'
  end

  end
end
