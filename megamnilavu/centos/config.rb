module MegamPkg
  class Ger
  CONFIG =  {:os => ['7'],
	:branch => "0.6",
        :name => "megamnilavu"}

 if !Gem::Specification::find_all_by_name('pkgr').any?
      puts "gem install pkgr"
      system 'gem install pkgr'
  end
  end
end
