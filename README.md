assigning static ip:

add this to /var/lib/lxc/[container_name]/config and change the last octet of your pref.

``lxc.net.0.ipv4.address = 10.0.3.210/24``
``lxc.net.0.ipv4.gateway = 10.0.3.1``


``systemctl restart lxc-net``
