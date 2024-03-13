#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Tries to catch all data emitted by eselect.

:maintainer: Mark Gomersbach (markgomersbach@gmail.com).
:maturity: 20181004
:requires: none
:platform: all
"""

from __future__ import absolute_import, print_function, unicode_literals

import distro

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
    import salt.modules.eselect

    __salt__ = {
        "cmd.run": salt.modules.cmdmod._run_quiet,
        "cmd.run_all": salt.modules.cmdmod._run_all_quiet,
        "eselect.get_modules": salt.modules.eselect.get_modules,
        "eselect.get_current_target": salt.modules.eselect.get_current_target,
    }


def __virtual__():
    """Check for Gentoo family."""
    if "gentoo" in distro.id():
        return "eselect_grain"
    return (False, "This is not a Gentoo family OS")


def _exec_action(
    module,
    action,
    module_parameter=None,
    action_parameter=None,
    state_only=False,
):
    """Execute an arbitrary action on a module.

    module
        name of the module to be executed
    action
        name of the module's action to be run
    module_parameter
        additional params passed to the defined module
    action_parameter
        additional params passed to the defined action
    state_only
        don't return any output but only the success/failure of the operation
    """
    out = __salt__["cmd.run"](
        "eselect --brief --colour=no {0} {1} {2} {3}".format(
            module, module_parameter or "", action, action_parameter or ""
        ),
        python_shell=False,
    )
    out = out.strip().split("\n")

    if out[0].startswith("!!! Error"):
        return False

    if state_only:
        return True

    if len(out) < 1:
        return False

    if len(out) == 1 and not out[0].strip():
        return False

    return out


def _get_modules():
    """List available ``eselect`` modules.

    CLI Example:
    .. code-block:: bash
        salt '*' eselect.get_modules
    """
    modules = []
    module_list = _exec_action("modules", "list", action_parameter="--only-names")
    if not module_list:
        return None

    for module in module_list:
        if module not in ["help", "usage", "version"]:
            modules.append(module)

    return modules


def _get_target_list(module, action_parameter=None):
    """List available targets for the given module.

    module
        name of the module to be queried for its targets
    action_parameter
        additional params passed to the defined action
    """
    exec_output = _exec_action(module, "list", action_parameter=action_parameter)

    if not exec_output:
        return None

    target_list = []

    if isinstance(exec_output, list):
        for item in exec_output:
            target_list.append(item.split(None, 1)[0])
        return target_list

    return None


def _get_current_target(module, module_parameter=None, action_parameter=None):
    """Get the currently selected target for the given module.

    module
        name of the module to be queried for its current target
    module_parameter
        additional params passed to the defined module
    action_parameter
        additional params passed to the 'show' action
    """

    result = _exec_action(
        module,
        "show",
        module_parameter=module_parameter,
        action_parameter=action_parameter,
    )[0]

    if not result:
        return None

    if result in ["(unset)", "(none)"]:
        return None

    return result


def eselect_update():
    edata = {}
    for mod in _get_modules():
        try:
            selected = _get_current_target(mod)
            edata[mod] = selected
        except:
            pass

    return {"eselect": edata}


if __name__ == "__main__":
    print(eselect_update())
