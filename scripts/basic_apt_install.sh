    set -x
    apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    apt-utils build-essential autoconf libtool libssl-dev libffi-dev libyaml-dev libzmq3-dev \
    zlib1g-dev libbz2-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev libffi-dev libreadline-dev \
    nodejs npm \
    git curl \
    sqlite3 libsqlite3-dev \
    libpq-dev \
    cron sudo \
    screen less vim ack-grep wget 