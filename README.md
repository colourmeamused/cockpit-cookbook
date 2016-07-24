cockpit cookbook
====================================

This cookbook installs and configures the [Cockpit server administration interface](http://cockpit-project.org/).


Scope
-----
Cockpit is installed as a package from the Red Hat Extras repository. Attributes can be used to configure the Cockpit service. Initially supports  Red Hat Enterprise Linux 7.1+, with CentOS support coming soon.

The goal is to keep the cookbook and code simple and minimal.

Requirements
------------
- Tested to work with Chef 12.7.x or higher
- Requires a system with a valid and active Red Hat Subscription and access to Red Hat repositories from redhat.com or via Satellite / Katello.


Usage
-------
Place a dependency on the `cockpit` cookbook in your
cookbook's metadata.rb:

```ruby
depends 'cockpit', '~> 0.2.0'
```

Or include the default recipe in your run list as ``'recipe[cockpit]'``.


This cookbook depends on the (firewalldconfig cookbook) and the (Red Hat Subscription Manager cookbook).

Attributes
------------

TODO: Support for custom port and other parameters in cockpit.conf



Testing
-------

Integration tests are written in (BATS)[https://github.com/sstephenson/bats]

Contributing
------------

1. Fork it ( https://github.com/colourmeamused/cockpit-cookbook )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
