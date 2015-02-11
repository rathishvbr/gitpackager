module MegamPkg
  class Ger
  CONFIG =  {:os => ['7'],
        :name => "megamcib", 
        :name_node => "megamcibn",
        :git => "https://github.com/megamsys/cloudinabox.git"}

  if !Gem::Specification::find_all_by_name('fpm').any?
      puts "gem install fpm"
      system 'gem install fpm'
  end

  end
end
