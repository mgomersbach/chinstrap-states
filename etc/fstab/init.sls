# Mount set
{% for mount in salt['pillar.get']('mounts') %}
mount_and_fstab_{{ mount }}:
  mount.mounted:
    {% for entry in salt['pillar.get']('mounts:' + mount) %}
    {% for var, val in entry.items() %}
    - {{ var }}: {{ val }}
    {% endfor %}
{% endfor %}
{% endfor %}
