# Why?

I needed to use openvpn with username/password and 2fa.  UI tools on Ubuntu aren't working.

# To Use:

    make all
    echo -e "[your vpn username]\n[your vpn password]" > ~/.vpncreds
    sudo openvpn --config client.split.ovpn --auth-user-pass ~/.vpncreds
