A simple reference architecture and guide for an automated build process driven by FPM.

* `.gitignore`: By default ignores ruby bundle files and rpms that are generated. Add any other package types you need to prevent from adding to your repo.
* `build`: Edit the application name, description, dependencies, etc. in the top section. If you need multiple packages built together (do you, though?), copy the APP1 block as many times as needed and move the iteration increase until after the last app section.
* `Gemfile`: Should not need any editing unless this is a Ruby application. Installs fpm using bundle. Not necessary if fpm is installed system-wide.
* `iteration`: Increments after every successful build. Remove the file or set the contents to `1` when bumping the version number.
* `Makefile`: Edit to place file in the appropriate location(s).
* `setup.sh`: Copies the basic files to another path, for use when adding this setup to another repo.
* `version`: Always modify this to reflect your application's version.

## Usage
Get started by pointing `setup.sh` at another directory with an application in it already:

    ./setup.sh ../otherapp
    
Change into the application's directory and edit the configuration files:

    cd ../otherapp
    vi {build,Makefile,version}
    
You can now run `build` in one of two ways:
### With global fpm
```
$ ./build
Creating build in /tmp/tmp.5VsTt2VIVw
install -d /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 .gitignore           /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 build                /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 Gemfile              /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 iteration            /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 Makefile             /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 setup.sh             /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 version              /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 README.md            /tmp/tmp.5VsTt2VIVw/var/www/app
Created package {:path=>"appname-0.1.0-0.01.el7.x86_64.rpm"}
```

### With bundler
```
$ bundle install
Fetching gem metadata from https://rubygems.org/...........
Fetching version metadata from https://rubygems.org/...
Fetching dependency metadata from https://rubygems.org/..
Installing cabin 0.9.0
Installing backports 3.8.0
Installing ffi 1.9.18 with native extensions
Installing clamp 1.0.1
Installing dotenv 2.2.1
Installing json 1.8.6 with native extensions
Installing insist 1.0.0
Installing mustache 0.99.8
Installing stud 0.0.22
Installing io-like 0.3.0
Using bundler 1.11.2
Installing arr-pm 0.0.10
Installing childprocess 0.7.0
Installing pleaserun 0.0.29
Installing ruby-xz 0.2.3
Installing fpm 1.8.1
Bundle complete! 1 Gemfile dependency, 17 gems now installed.
Gems in the groups system_tests and development were not installed.
Bundled gems are installed into ./vendor.

$ bundle exec ./build
Creating build in /tmp/tmp.5VsTt2VIVw
install -d /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 .gitignore           /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 build                /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 Gemfile              /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 iteration            /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 Makefile             /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 setup.sh             /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 version              /tmp/tmp.5VsTt2VIVw/var/www/app
install -m 0644 README.md            /tmp/tmp.5VsTt2VIVw/var/www/app
Created package {:path=>"appname-0.1.0-0.01.el7.x86_64.rpm"}
```

## Verification
Upon creation, you can inspect your artifacts to ensure they received the correct values.
```
$ rpm -qpi appname-0.1.0-0.01.el7.x86_64.rpm
Name        : appname
Version     : 0.1.0
Release     : 0.01.el7
Architecture: x86_64
Install Date: (not installed)
Group       : default
Size        : 3150
License     : unknown
Signature   : (none)
Source RPM  : appname-0.1.0-0.01.el7.src.rpm
Build Date  : Fri 02 Jun 2017 03:44:58 PM UTC
Build Host  : chi-build05.mss.local
Relocations : /
Packager    : you@example.com
Vendor      : example.com
URL         : http://example.com/no-uri-given
Summary     : Reference application, change these variables
Description :

$ rpm -qpl appname-0.1.0-0.01.el7.x86_64.rpm
/var/www/app/.gitignore
/var/www/app/Gemfile
/var/www/app/Makefile
/var/www/app/README.md
/var/www/app/build
/var/www/app/iteration
/var/www/app/setup.sh
/var/www/app/version
```

## Storage
Each run of `build` will create at least one build artifact. Don't forget to transfer the artifacts to the appropriate location for long term storage, or remove if no longer necessary.
