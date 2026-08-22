#!/usr/bin/env sh

set -Eeuo pipefail
trap 'echo "Failed on line $LINENO"' ERR

# ==============================================================================
# Terminal UI Colors & Formatting
# ==============================================================================
# RESET="\e[0m"
# BOLD="\e[1m"
# DIM="\e[2m"
# C_BLUE="\e[34m"
# C_CYAN="\e[36m"
# C_GREEN="\e[32m"
# C_YELLOW="\e[33m"
# C_RED="\e[31m"
# C_MAGENTA="\e[35m"

DETECTED_OS=$(awk -F= '/^ID=/{gsub(/"/, "", $2); print $2}' /etc/os-release)

case "$DETECTED_OS" in

fedora)

    echo "Fedora Linux detected , initiating setup ... "
    LOCAL_PKGS=(
        "docker"
        "docker-compose"
        "gh"
        "ghostty"
        "git"
        "localsend"
        "niri"
        "nix"
        "nix-daemon"
        "noctalia"
        "noctalia-greeter-compositor"
        "obs-studio"
        "pgcli"
        "postgresql-server"
        "satty"
        "sddm"
        "xdg-desktop-portal"
        "xdg-desktop-portal-gtk"
        "xdg-desktop-portal-gnome"
        "zsh"
    )
    LOCAL_REPOS=(
        "scottames/ghostty"
    )
    # NIX_FLAKES=(
    #     "git+https://github.com/youwen5/zen-browser-flake"
    # )
    NIX_PKGS=(
        "age"
        "awww"
        "bat"
        "btop"
        "bun"
        "cargo"
        "cava"
        "chromium"
        "cliphist"
        "cloudflared"
        "cmtrix"
        "dbeaver-bin"
        "delta"
        "drawio"
        "direnv"
        "duf"
        "eza"
        "fastfetch"
        "fd"
        "figma-linux"
        "firefox-devedition"
        "fzf"
        "gcc"
        "github-desktop"
        "gitleaks"
        "hyprpicker"
        "insomnia"
        "just"
        "lazydocker"
        "lazygit"
        "lazysql"
        "minio"
        "ncdu"
        "neovim"
        "nodejs"
        "obsidian"
        "oh-my-posh"
        "onlyoffice-desktopeditors"
        "pass"
        "pipes"
        "postman"
        "ripgrep"
        "rmlint"
        "rofi"
        "sops"
        "stow"
        "tealdeer"
        "telegram-desktop"
        "tor-browser"
        "tty-clock"
        "vlc"
        "vscode"
        "yazi"
        "yq"
        "zellij"
        "zoxide"
        "zsh-autosuggestion"
        "zsh-history-substring"
        "zsh-syntax-highlighting"
    )
    KDE_BLOAT=(
        "kontact" "skanpage" "akregator" "/usr/bin/contactprintthemeeditor" "/usr/bin/contactthemeeditor" "/usr/bin/kdeconnect-app"
        "/usr/bin/kdeconnect-sms" "/usr/bin/headerthemeeditor" "kmail" "/usr/bin/krdc" "krfb" "ktnef" "neochat" "dragon" "/usr/bin/elisa"
        "qrca" "korganizer" "kleopatra" "/usr/bin/akonadiimportwizard" "ktnef" "kaddressbook" "gnome-abrt" "plasma-welcome" "plasma-systemmonitor"
        "/usr/bin/drkonqi-coredump-gui" "/usr/bin/kjournaldbrowser" "xwaylandvideobridge" "kdebugsettings" "kfind" "kwalletmanager5" "kwrite" "kmouth"
    )

    echo "installing local packages ..."
    sudo dnf upgrade --refresh -y
    sudo dnf copr enable -y "${LOCAL_REPOS[@]}"
    sudo dnf install -y "${LOCAL_PKGS[@]}"

    if rpm -q plasma-desktop >/dev/null 2>&1; then
        echo "Removing KDE Plasma bloatware ..."
        sudo dnf remove -y "${KDE_BLOAT[@]}"
        echo "importing KDE configuration"
        nix run nixpkgs\#konsave -- -i ~/setup/config/kde-plasma/kde.knsv
        nix run nixpkgs\#konsave -- -a kde
    fi

    echo "enabling nix-daemon ..."
    sudo systemctl enable --now nix-daemon

    echo "installing nix packages ..."
    NIXPKGS_ALLOW_UNFREE=1 \
    NIXPKGS_ALLOW_INSECURE=1 \
    nix profile add --impure "${NIX_PKGS[@]/#/nixpkgs#}"

    # for flake in "${NIX_FLAKES[@]}"; do
    #     nix profile add "$flake"
    # done
    
    echo "downloading app through other sources"
    ~/.nix-profile/bin/bun i -g @google/gemini-cli
    curl -f https://zed.dev/install.sh | sh

    echo "cloning setup repo ..."
    git clone https://github.com/g1d3onFr0st/setup.git

    echo "stowing files ..."
    ~/.nix-profile/bin/stow -t ~ -d ~/setup/dotfiles --adopt *

    echo "changing shell ... "
    sudo chsh -s "$(command -v zsh)" "$USER"

    echo "setting up GRUB"
    sudo mkdir -p /boot/grub2/themes
    sudo cp -r ~/setup/config/grub/themes/* /boot/grub2/themes/
    sudo rm -rf /etc/default/grub
    sudo cp ~/setup/config/grub/grub /etc/default/
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg

    echo "setting up DNF"
    sudo rm -rf /etc/dnf/dnf.conf
    sudo cp ~/setup/config/dnf/dnf.conf /etc/dnf/

    echo "setting up postgresql server"
    sudo /usr/bin/postgresql-setup --initdb
    sudo systemctl enable --now postgresql
    echo "enter : ( ALTER USER postgres WITH PASSWORD 'YOUR_DATABASE_PASSWORD'; ) and then enter : ( exit ) "
    sudo -iu postgres pgcli
    sudo rm -rf /var/lib/pgsql/data/pg_hba.conf
    sudo cp ~/setup/config/postgresql-server/pg_hba.conf /var/lib/pgsql/data/
    sudo chown postgres:postgres /var/lib/pgsql/data/pg_hba.conf
    sudo systemctl restart postgresql

    echo "Setting Up Tealdeer"
    tldr --update

    echo "setting up noctalia greeter"
    sudo systemctl disable plasmalogin
    sudo systemctl enable noctalia-greeter-compositor
    sudo rm -rf /etc/greetd/config.toml
    sudo cp ~/setup/config/greetd/config.toml /etc/greetd/


    echo "running cleanup"
    sudo dnf update -y && sudo dnf upgrade -y
    sudo dnf autoremove -y

    sudo echo ""
    echo "setup is done , rebooting in "
    echo "3"
    sleep 1
    echo "2"
    sleep 1
    echo "1"
    sleep 1
    sudo systemctl reboot

    ;;

*)

    echo -e "${C_RED}Unsupported OS ($DETECTED_OS). This script strictly supports Fedora.${RESET}"
    exit 1

    ;;

esac
