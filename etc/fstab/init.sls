# Mount set
{% for mount, entry in salt['pillar.get']('mounts') %}
mount_and_fstab_{{ mount }}:
  mount.mounted:
    {% for var, val in entry.items() %}
    - {{ var }}: {{ val }}
    {% endfor %}
{% endfor %}
