#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Get native cpu flags.

:maintainer: Mark Gomersbach (markgomersbach@gmail.com)
:maturity: 20190722
:requires: none
:platform: all
"""

from __future__ import absolute_import, print_function, unicode_literals

import re
import platform
import shutil

if __name__ == "__main__":
    import salt.config
    import salt.loader

    __opts__ = salt.config.minion_config("/etc/salt/minion")
    __grains__ = salt.loader.grains(__opts__)
    __opts__["grains"] = __grains__
    __utils__ = salt.loader.utils(__opts__)
    __salt__ = salt.loader.minion_mods(__opts__, utils=__utils__)
else:
    import salt.modules.cmdmod

    __salt__ = {
        "cmd.run": salt.modules.cmdmod._run_quiet,
        "cmd.run_all": salt.modules.cmdmod._run_all_quiet,
        "eselect.get_modules": salt.modules.eselect.get_modules,
        "eselect.get_current_target": salt.modules.eselect.get_current_target,
    }


def __virtual__():
    """Check for Gentoo family and platform cpuid2cpuflags tool."""

    if "Gentoo" in platform.linux_distribution()[0]:
        if shutil.which("cpuid2cpuflags") is not None:
            return "native_cpu"
    return (
        False,
        "This is not a Gentoo family OS or cpuid2cpuflags is missing",
    )


def _get_cflags():
    """List native cflags.

    CLI Example:
    .. code-block:: bash
        salt '*' native_cpu.get_cflags
    """
    gccout = __salt__["cmd.run"](
        "gcc -### -E - -march=native", python_shell=False
    )
    pattern = r"cc1.*\""
    out = re.findall(pattern, gccout)
    nomno = [
        i for i in out[0].replace('"', "").split(" ")[4:] if "-mno-" not in i
    ]
    cflags = []
    i = 0
    while i < len(nomno):
        cur = nomno[i]
        if "-param" in cur:
            nxt = nomno[i + 1]
            i += 2
            cflags.append(cur + " " + nxt)
            continue
        i += 1
        cflags.append(cur)
    return cflags


def _get_cpuflags():
    """List native cpuflags.

    CLI Example:
    .. code-block:: bash
        salt '*' native_cpu.get_cpuflags
    """
    cpuidout = __salt__["cmd.run"]("cpuid2cpuflags", python_shell=False)

    return cpuidout.split(":")[1].strip().split(" ")


def native_update():
    cpudata = {}
    cpudata["cflags"] = _get_cflags()
    cpudata["cpuflags"] = _get_cpuflags()
    return {"cpu_native": cpudata}


if __name__ == "__main__":
    print(native_update())
