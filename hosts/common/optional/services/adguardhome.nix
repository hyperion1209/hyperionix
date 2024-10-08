{ pkgs, config, configVars, ... }:
{
  services.adguardhome = {
    enable = true;
    package = pkgs.adguardhome;
    openFirewall = true;
    mutableSettings = false;
    settings = {
      http = {
        address = "0.0.0.0:3000";
      };
      users = [
        {
          name = "${configVars.username}";
          password = "$2a$12$sDK2rREolH7.QkuivRnEzOJU3iGhLKJ/MteFHB2Lk35U32YRDLYgC";
        }
      ];
      theme = "dark";
      dns = {
        bind_hosts = [
          "0.0.0.0"
        ];
        upstream_dns = [
          "1.1.1.1"
          "1.0.0.1"
        ];
        bootstrap_dns = [
          "1.1.1.1"
          "1.0.0.1"
        ];
        cache_size = 100000;
        enable_dnssec = true;
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        parental_enabled = false;
        safe_search = {
          enabled = false;
        };
      };
      filters = map(url: { enabled = true; url = url; }) [
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_4.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_5.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_24.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_27.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_32.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_34.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_38.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_3.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_33.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_6.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_7.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_23.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_30.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_12.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_8.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_10.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_31.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"
        "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
        "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
        "https://v.firebog.net/hosts/static/w3kbl.txt"
        "https://adaway.org/hosts.txt"
        "https://v.firebog.net/hosts/AdguardDNS.txt"
        "https://v.firebog.net/hosts/Admiral.txt"
        "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
        "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
        "https://v.firebog.net/hosts/Easylist.txt"
        "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
        "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"
        "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
        "https://v.firebog.net/hosts/Easyprivacy.txt"
        "https://v.firebog.net/hosts/Prigent-Ads.txt"
        "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"
        "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
        "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
        "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt"
        "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt"
        "https://v.firebog.net/hosts/Prigent-Crypto.txt"
        "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"
        "https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt"
        "https://phishing.army/download/phishing_army_blocklist_extended.txt"
        "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
        "https://v.firebog.net/hosts/RPiList-Malware.txt"
        "https://v.firebog.net/hosts/RPiList-Phishing.txt"
        "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
        "https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts"
        "https://urlhaus.abuse.ch/downloads/hostfile/"
        "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser"
      ];
      dhcp = {
        enabled = false;
        interface_name = "eno1";
        dhcpv4 = {
          gateway_ip = "192.168.1.1";
          subnet_mask = "255.255.255.0";
          range_start = "192.168.1.10";
          range_end = "192.168.1.100";
        };
      };
    };
  };
}
