# Mount set
{% for mount in salt['pillar.get']('mounts') %}
mount_and_fstab_{{ mount }}:
  mount.mounted:
    {% for var, val in salt['pillar.get']('mounts:' + mount).items() %}
    - {{ var }}: {{ val }}
{% endfor %}
{% endfor %}
