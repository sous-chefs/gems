# Limitations

## Package Availability

This cookbook manages a static RubyGems repository served by Apache and an optional rsync-based
mirror job. It does not install a vendor application from a dedicated upstream package repository.

### APT (Debian/Ubuntu)

* Debian 12 and 13 provide distribution packages for Ruby, Apache, and rsync on the standard Debian
  architectures.
* Ubuntu 22.04 and 24.04 provide distribution packages for Ruby, Apache, and rsync on the standard
  Ubuntu architectures.

### DNF/YUM

* Not supported by this cookbook's current platform contract. The previous Kitchen configuration
  listed several RHEL-family platforms, but `metadata.rb` only declared Debian and Ubuntu support.

### Zypper

* Not supported by this cookbook's current platform contract.

## Architecture Limitations

The cookbook relies on operating system packages and the RubyGems client. No architecture-specific
upstream binary packages are downloaded by the cookbook.

## Source/Compiled Installation

No source builds are performed by this cookbook.

## Known Issues

* RubyGems now provides `gem generate_index` through the `rubygems-generate_index` gem.
* The legacy `gems::mirror` recipe mirrored `rsync://master.mirror.rubyforge.org/gems/`. RubyForge
  is obsolete, so `gems_mirror` exposes the source URL as a property instead of treating that mirror
  endpoint as a guaranteed working default.
