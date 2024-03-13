#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Get loca network interfaces and their details.

:maintainer: Mark Gomersbach (markgomersbach@gmail.com).
:maturity: 20240313
:requires: none
:platform: all
"""

from __future__ import absolute_import, print_function, unicode_literals


if __name__ == "__main__":
    import salt.config
    import salt.loader

    __opts__ = salt.config.minion_config("/etc/salt/minion")
    __grains__ = salt.loader.grains(__opts__)
    __opts__["grains"] = __grains__
    __utils__ = salt.loader.utils(__opts__)
    __salt__ = salt.loader.minion_mods(__opts__, utils=__utils__)
else:
    __salt__ = {
        "network.interfaces": salt.modules.network.interfaces,
    }


def __virtual__():
    return "network"


def network_update():
    network = {}
    for interface, details in __salt__["network.interfaces"]().items():
        network[interface] = details
    return {"network": network}


if __name__ == "__main__":
    print(network_update())
