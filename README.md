salt-lampdemo
=============

Saltstack States for a LAMP install on ubuntu and wordpress deployment. By using jinja templates it is possible to customize the whole mysql-wp connection.

* packages.sls  -> some sysadmin tools
* lamp/init.sls -> package installer state
* lamp/config.sls -> config state
* lamp/wordpress.sls -> wordpress installer

Note: I introduced some jinja hack to support more versions, but I cover only supported LTS releases.

Known bug: mysql 5.7 and saltstack  2015.8.8 (Beryllium) don't cooperate in user creation. It has to be done by hand.