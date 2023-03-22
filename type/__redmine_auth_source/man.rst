cdist-type__redmine_auth_source(7)
==================================

NAME
----
cdist-type__redmine_auth_source - Manage auth sources in Redmine


DESCRIPTION
-----------
This type can be used to manage auth sources in Redmine.

Currently, only LDAP is supported as an authentication source in Redmine.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
base-dn
   LDAP base DN
bind-dn
   LDAP bind DN
bind-pw
   password of ``--bind-dn``.
filter
   LDAP filter.
firstname-attr
   the LDAP attribute to get the user's first name from.

   Defaults to: ``givenName``
host
   host name or IP address of the LDAP server.
lastname-attr
   the LDAP attribute to get the user's last name from.

   Defaults to: ``sn``
login-attr
   the LDAP attribute to use as the login attribute (the value the user has to
   enter as their username)
mail-attr
   the LDAP attribute to get the user's e-mail address from.

   Defaults to: ``mail``
name
   name of the authentication source.

   Defaults to ``$__object_id``.
port
   port to connect to the ``--host``.
state
   One of:

   present
      the auth source is present
   absent
      the auth source is absent
timeout
   timeout
type
   Currently only one option is available: ``AuthSourceLdap``.

   Defaults to ``AuthSourceLdap``.


BOOLEAN PARAMETERS
------------------
ldaps
   enable LDAPS
no-verify-peer
   do not verify SSL/TLS certificate of the LDAP server
onthefly-register
   Enable "on-the-fly user creation".


EXAMPLES
--------

.. code-block:: sh

   # Add simple LDAP auth source (no encryption, no authentication)
   __redmine_auth_source LDAP-insecure \
      --host ldap.example.com --port 389 \
      --base-dn dc=example,dc=com \
      --login-attr cn

   # Add LDAP auth source (with LDAPS encryption and authentication)
   __redmine_auth_source LDAP-secure \
      --host ldap.example.com --port 636 --ldaps \
      --base-dn dc=example,dc=com \
      --bind-dn cn=redmine,ou=DSA,dc=example,dc=com \
      --bind-pw hunter2 \
      --login-attr cn


SEE ALSO
--------
- :strong:`cdist-type__redmine`\ (7)
- `RedmineLDAP <https://www.redmine.org/projects/redmine/wiki/RedmineLDAP>`__


AUTHORS
-------
Dennis Camera <dennis.camera--@--ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2021 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
