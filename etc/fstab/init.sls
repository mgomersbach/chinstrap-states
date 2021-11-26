# Mount set
{% for mount, settings in salt['pillar.get']('mounts', {}).items() %}
mount_and_fstab_{{ mount }}:
  mount.mounted:
    {{ settings }}
{% endfor %}
