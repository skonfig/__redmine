cdist-type__redmine_plugin(7)
=============================

NAME
----
cdist-type__redmine_plugin - Install Redmine plugins


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
install-dir
   The directory into which Redmine was installed.

   Defaults to: ``/usr/local/share/redmine``
name
   The name of the plugin.

   The correct value can be determined by running the following command on the
   unpacked plugin archive:

   .. code-block:: sh

      sed -n -e 's/.*Redmine::Plugin.register :\([^ ]*\).*/\1/p' "${plugin_dir:?}/init.rb"

   Defaults to ``${__object_id}``.
state
   One of:

   present
      The plugin is installed.
   absent
      The plugin is not installed.
url
   URL where the plugin can be downloaded.

   The file available at ``--url`` must be an archive extractable by
   :strong:`cdist-type__unpack`\ (7) and at the top level it must only have one
   directory.


BOOLEAN PARAMETERS
------------------
None.


EXAMPLES
--------

.. code-block:: sh

   # Install the Redhopper plugin (v2.0.0) in the default location (/usr/local/share/redmine)
   __redmine_plugin redhopper \
      --url 'https://framagit.org/infopiiaf/redhopper/-/archive/2.0.0/redhopper-2.0.0.tar.gz'

   # Remove the mega_calendar plugin (default location)
   __redmine_plugin mega_calendar --state absent


SEE ALSO
--------
:strong:`cdist-type__redmine`\ (7)


AUTHORS
-------
Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2021 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
