let vpn_dir = ($env.HOME | path expand | path join ".config/vpn")
let creds_file = ($vpn_dir | path join "ovpnauth.txt")
let pid_file = "/tmp/vpn.pid"

def vpn [region: string] {
    let ovpn_file = ($vpn_dir | path join $"rsv.($region).ovpn")
    if not ($ovpn_file | path exists) {
        print $"ERR: No VPN config found for region '($region)'"
        return
    }

    print $"OK: Connecting to VPN region '($region)'..."
    sudo openvpn --config $ovpn_file --auth-user-pass $creds_file
}

def vpn-bg [region: string] {
    let ovpn_file = ($vpn_dir | path join $"rsv.($region).ovpn")
    if not ($ovpn_file | path exists) {
        print $"No VPN config found for region '($region)'"
        return
    }

    print $"WARN: Starting VPN in background for region '($region)'..."
    sudo openvpn --config $ovpn_file --auth-user-pass $creds_file --daemon
}

def vpn-stop [] {
    print "WARN: Stopping VPN..."
    sudo pkill openvpn
}
