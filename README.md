cockpit cookbook
====================================

This cookbook installs and configures the [Cockpit server administration interface](http://cockpit-project.org/).


Scope
=====
- Supports RHEL 7.x
- Install and configure Cockpit service with packages from Red Hat Extras repo
- Optionally install Cockpit features - PCP metrics logging and Kubernetes dashboard
- Deploy custom SSL certificate for Cockpit from Chef Vault or a Chef data bag
- Configure firewalld and SELinux policies for Cockpit
- Specify port for Cockpit console

Requirements
============
- Tested to work with Chef 12.7.x or higher
- Requires a system with a valid and active Red Hat Subscription and access to Red Hat repositories from redhat.com or via Satellite / Katello.

Simple Cookbooks
================

This is intended to be the first of a series of simple cookbooks for RHEL 7.x / CentOS 7.x. The idea is to have simple reusable code, minimal dependencies and stick to best practices for RHEL 7.x.

- Always use RPM installs, from official repos where possible
- Include options to configure SELinux, Firewalld, SystemD services
- Common dependencies to support configuration of yum repos, Red Hat subscriptions, manage config files with Augeas, firewalld, and SELinux policies.


Usage
=====
Place a dependency on the `cockpit` cookbook in your
cookbook's metadata.rb:

```ruby
depends 'cockpit', '~> 0.4.0'
```

Or include the default recipe in your run list as ``'recipe[cockpit]'``.


This cookbook depends on the [firewalld cookbook](https://supermarket.chef.io/cookbooks/firewalld), the [augeas cookbook](https://supermarket.chef.io/cookbooks/augeas) and the [Red Hat Subscription Manager cookbook](https://supermarket.chef.io/cookbooks/redhat_subscription_manager).

Attributes
==========

These attributes can be used to customize the Cockpit install.

* `node['cockpit']['port']` - Modify the listen port for Cockpit.  
   Defaults to 9090.
* `node['cockpit']['logintitle']` - Set the LoginTitle attribute in cockpit.conf, which is shown on the login page.   
* `node['cockpit']['features']['pcp']` - Install the PCP framework to allow Cockpit to store system metrics.
* `node['cockpit']['features']['kubernetes']` - Install the [Kubernetes dashboard](http://cockpit-project.org/guide/latest/feature-kubernetes.html). At the moment this uses the CentOS 7 Extras repo to get the cockpit-kubernetes package.
* `node['cockpit']['configure_repo']` - Configure / enabled yum repositories for Cockpit as specified by `node['cockpit']['repo']`
* `node['cockpit']['repo']` - Three allowed values here:

>>1) `rhel-7-server-extras-rpms` : Use RHEL Extras repo for Cockpit packages, except `cockpit-kubernetes`, if enabled, which has to come form CentOS Extras.

>>2) `centos-extras` : Configure CentOS 7 Extras repo to install Cockpit packages only. It is preferable to use the [`yum-centos` cookbook](https://github.com/chef-cookbooks/yum-centos) instead.

>>3) `cockpit-preview` - Install the latest, bleeding edge versions of Cockpit packages from the [cockpit-preview COPR repo](https://copr.fedorainfracloud.org/coprs/g/cockpit/cockpit-preview/)

Custom SSL certificate
----------------------

A custom SSL certificate and key can be provided as follows:
* `node['cockpit']['ssl_vault']` - Name of data bag or Chef vault
* `node['cockpit']['ssl_item']` - Name of item in vault / data bag containing JSON keys for the certificate (`cert`) and private key (`key`) in the PEM format. See `test/integration/data_bags` for an example.






Testing
=======

Integration tests are written in [BATS](https://github.com/sstephenson/bats)

Contributing
============

1. Fork it ( https://github.com/colourmeamused/cockpit-cookbook )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
