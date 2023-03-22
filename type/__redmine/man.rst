cdist-type__redmine(7)
======================

NAME
----
cdist-type__redmine - Install Redmine


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
attachments-path
   The path on the filesystem where Redmine should store attachments
   (i.e. uploaded files).

   Defaults to: ``${install_dir}/files``.
db-host
   Hostname of the database server.

   Compatible ``--db-type``: MySQL, PostgreSQL.

   Defaults to: ``localhost``
db-name
   non SQLite:
      The name of the database to connect to

      Defaults to: ``redmine``
   SQLite:
      path of the DB file (relative to the installation directory).

      NB: The Redmine service user must have write permission to the parent
      directory.
      This type will make the ``db/`` subdirectory writable for the default
      location to work.

      Defaults to: ``db/redmine.sqlite3``
db-password
   Password of ``--db-user``.

   Compatible ``--db-type``: MySQL, PostgreSQL, SQL Server.
db-port
   Port at which the database server is listening on ``--db-host``.

   Compatible ``--db-type``: MySQL.
db-schema
   Database schema that Redmine should use.

   Compatible ``--db-type``: PostgreSQL.

   Defaults to: ``public``
db-type
   Type of database server that Redmine should use.

   One of:

   * ``sqlite``: SQLite (not suited for production environments).
   * ``mysql``: MySQL or MariaDB.
   * ``postgresql``: PostgreSQL.
   * ``sqlserver``: Microsoft SQL Server.

   Defaults to: ``sqlite``
db-user
   User to use to connect to the database server.

   Compatible ``--db-type``: MySQL, PostgreSQL, SQL Server.
mail
   The method Redmine should use to send out e-mails.

   Values values are:

   ``:sendmail``
      use the system's :strong:`sendmail`\ (1) binary.
   ``smtp://...``
      a URL of the form ``smtp://[username:password@]smtp.server[:port][?query]``.
version
   ...


BOOLEAN PARAMETERS
------------------
update-gems
   update already installed gems if newer versions compatible with the Gemfile are available.


EXAMPLES
--------

.. code-block:: sh

    # Install Redmine and keep its dependencies up to date (checked on every cdist run)
    __redmine --version latest --update-gems


SEE ALSO
--------
:strong:`cdist-type__redmine_auth_source`\ (7),
:strong:`cdist-type__redmine_plugin`\ (7),
:strong:`cdist-type__redmine_user`\ (7)


AUTHORS
-------
Dennis Camera <dennis.camera--@--ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2021 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
