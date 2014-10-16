module MegamPkg
  class Ger
  CONFIG =  {:os => ['trusty', 'precise'],
        :name => "megamgulpd",
        :git => "https://github.com/megamsys/gulp.git"}

  if !Gem::Specification::find_all_by_name('fpm').any?
      puts "gem install fpm"
      system 'gem install fpm'
  end

  end
end
