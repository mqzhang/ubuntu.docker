    set -x
    sudo apt-get update --yes && \
    sudo apt-get install --yes --no-install-recommends \
    apt-utils build-essential autoconf libtool libssl-dev libffi-dev libyaml-dev libzmq3-dev \
    zlib1g-dev libbz2-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev libffi-dev libreadline-dev \
    git curl wget unzip \
    sqlite3 libsqlite3-dev \
    libpq-dev \
    cron sudo \
    screen less ack-grep lsof \
    emacs vim \
    fzf ripgrep bat eza zoxide plocate btop apache2-utils fd-find tldr \
    build-essential pkg-config autoconf bison clang rustc \
    libssl-dev libreadline-dev zlib1g-dev libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libjemalloc2 \
    libvips imagemagick libmagickwand-dev mupdf mupdf-tools gir1.2-gtop-2.0 gir1.2-clutter-1.0 \
    redis-tools sqlite3 libsqlite3-0 libmysqlclient-dev libpq-dev postgresql-client postgresql-client-common \
    pipx
 
    # use pipx to install uv Install pipx for managing Python applications
    pipx ensurepath
    pipx install uv    # Install pipx for managing Python applications