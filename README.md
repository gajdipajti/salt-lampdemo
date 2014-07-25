salt-lampdemo
=============

Saltstack States for a LAMP install and wordpress deployment. Using jinja templates it is possible to customize the whole mysql-wp connection.

* packages.sls  -> some sysadmin tools
* lamp/init.sls -> package installer state
* lamp/config.sls -> config state
* lamp/wordpress.sls -> wordpress installer
