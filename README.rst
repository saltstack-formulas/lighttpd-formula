================
lighttpd-formula
================

A simple saltstack formula to install and configure lighttpd.

This formula has been developed distributing id and state declarations in
different files to make it usable in most situations. It should be useful in
scenarios ranging from a simple install of the packages (without any special
configuration) to a more complex set-up.

General customization strategies
================================

First, **see if providing pillar data is enough for your customization needs**
That's the recommended way and should be enough for most cases. See that
sometimes there's a key named `extra_conf` that's used to add arbitrary
configuration lines in the templates provided.

When providing pillar data is not enough for your needs, you can apply the
_Template Override and Files Switch_ (TOFS) pattern as described in the
documentation file `TOFS_pattern.rst`.

.. note::

    Currently this formula supports RedHat, Debian, Suse and Arch os_family.
    Some distributions provide modules as extra packages, you can add them
    via pillar extra_packages list.
    
    TODO:
    This formula doesn't manage lighttpd configuration modules on all Systems
    only Debian is supported.
    Vhost support

    See the full `Salt Formulas
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_ doc.

Available states
================

.. contents::
    :local:

``lighttpd``
------------

Meta-state for inclusion of all states for lighttpd.

``lighttpd.install``
--------------------

Installs the lighttpd package. If extra_packages are supported via pillar.

``lighttpd.config``
-------------------

Configures the lighttpd package.

``lighttpd.service``
--------------------

Manages the startup and running state of the lighttpd service.

``lighttpd.modules``
--------------------

Manages the modules via lighty-mods-enable/disable on Debian systems.
This is pillar driven see pillar.example


