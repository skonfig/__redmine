cdist-type__ssrq_redmine_user(7)
================================

NAME
----
cdist-type__ssrq_redmine_user - Manage Redmine user accounts


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
auth-source
   The name of the auth source this user should get its password from.

   If not used, Redmine will use the internal database (the default).
email
   An email address of the user.

   Required if the user is created.

   Can be used multiple times.
   The first value will be the primary email address.
   The rest of the values will be used as additional notification email addresses.
firstname
   The first name of the person using this user account.

   Required if the user is created.
lastname
   The last name of the person using this user account.

   Required if the user is created.
install-dir
   The directory into which Redmine was installed.

   Defaults to: ``/usr/local/share/redmine``
login
   login name of the user.

   Defaults to ``$__object_id``.
password
   The password of this user.

   If not used the user's password will not be changed.

   | This paramter accepts either a plain-text password or a password hash of
     the form:
   | ``$sha1$salt$hash`` with ``salt`` being a random 16 character hexstring
     and ``hash`` being ``sha1(salt + sha1(password))``, e.g.:
   | ``$sha1$42c1025f25c70c81b52453fa8d7b28b2$c7188d9992176dd87a98a43c49b68fefa9d44b60``

   **NB:** Plain-text passwords must not start with a dollar sign (``$``).
state
   One of:

   present
      The user exists and is active.
   locked
      The user exists but is locked.
   absent
      The user does not exist.


BOOLEAN PARAMETERS
------------------
admin
   Make this user an administrator.

   The user's administator flag will be removed if this parameter is not used.
must-change-password
   Force a change of password on the next login for this user.


EXAMPLES
--------

.. code-block:: sh

   # Create a user fifi
   __ssrq_redmine_user fifi \
      --firstname Fi --lastname Fi --email fifi@example.com --password fifi1234

   # Change password of the user admin (requires the user to exist already)
   __ssrq_redmine_user admin \
      --admin \
      --password '$sha1$42c1025f25c70c81b52453fa8d7b28b2$c7188d9992176dd87a98a43c49b68fefa9d44b60'

   # Lock user fifi
   __ssrq_redmine_user fifi --state locked

   # Remove user fifi
   __ssrq_redmine_user fifi --state absent


SEE ALSO
--------
| :strong:`cdist-type__ssrq_redmine`\ (7)
| :strong:`cdist-type__ssrq_redmine_auth_source`\ (7)

AUTHORS
-------
Dennis Camera <dennis.camera-@-ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2021 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
