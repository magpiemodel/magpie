# MAgPIE - Model of Agricultural Production and its Impact on the Environment
# Dockerfile for complete MAgPIE setup
#
# To build this image:
# docker build -t magpie .
#
# To run MAgPIE interactively:
# docker run -it -v /path/to/your/gamslice.txt:/opt/gams/gamslice.txt magpie
#
# Then inside the container:
# Rscript start.R
#
# To persist output data:
# docker run -it -v /path/to/your/gamslice.txt:/opt/gams/gamslice.txt \
#            -v $(pwd)/output:/opt/magpie/output magpie
#
# To use a checked out copy of magpie on your system, run within the
# repository folder:
# docker run -it -v /path/to/your/gamslice.txt:/opt/gams/gamslice.txt \
#            -v $(pwd):/opt/magpie magpie

FROM ubuntu:26.04
ARG UBUNTU_CODENAME=resolute # check https://en.wikipedia.org/wiki/Ubuntu_version_history
RUN bash -c "[[ `cat /etc/os-release | grep '^VERSION_CODENAME=' | cut -d= -f2` = '${UBUNTU_CODENAME}' ]] || exit 1"

ARG LOCALE=C.UTF-8
ENV LC_ALL=${LOCALE}
ENV LANG=${LOCALE}

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
  apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y \
    texlive-full && \
  rm -rf /var/lib/apt/lists/*

# We do not want a minimal image, as we want to use this interactively
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
  apt update && DEBIAN_FRONTEND=noninteractive apt install -y unminimize && \
  yes | unminimize && \
  rm -rf /var/lib/apt/lists/*

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
  apt update && DEBIAN_FRONTEND=noninteractive apt install -y \
    # Basic tools
    wget \
    curl \
    git \
    unzip \
    vim \
    # Build tools
    build-essential \
    cmake \
    # System libraries required for R packages
    libfontconfig1 \
    libfontconfig1-dev \
    libfreetype-dev \
    libfribidi-dev \
    libgdal-dev \
    libgit2-dev \
    libglpk-dev \
    libharfbuzz-dev \
    libjpeg-dev \
    libnetcdf-dev \
    libpng-dev \
    libpoppler-cpp-dev \
    libssl-dev \
    libtiff5-dev \
    libudunits2-dev \
    libxml2-dev \
    libcairo2-dev \
    libuv1-dev \
    pari-gp \
    qpdf \
    pandoc \
    ca-certificates && \
  rm -rf /var/lib/apt/lists/*

# install rig (R version manager) and R
RUN curl -L https://rig.r-pkg.org/deb/rig.gpg -o /etc/apt/trusted.gpg.d/rig.gpg && \
  sh -c 'echo "deb http://rig.r-pkg.org/deb rig main" > /etc/apt/sources.list.d/rig.list' && \
  apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y r-rig
ARG R_VERSION=4.6 # do not pass patch level; NOT 4.6.0
RUN rig add ${R_VERSION}

# Set up R package manager pak
ENV RSPM="https://packagemanager.posit.co/cran/__linux__/${UBUNTU_CODENAME}/latest"
RUN Rscript -e 'stopifnot(R.version$arch == "x86_64")'
ENV R_UNIVERSE_URL="https://pik-piam.r-universe.dev/bin/linux/${UBUNTU_CODENAME}-x86_64/${R_VERSION}/"
RUN echo "options(repos = c(pikpiam = Sys.getenv('R_UNIVERSE_URL'), CRAN = Sys.getenv('RSPM')))" > ~/.Rprofile

RUN Rscript -e 'install.packages("pak"); pak::pkg_install("languageserver")'

WORKDIR /opt/magpie
RUN git clone https://github.com/magpiemodel/magpie.git .

# Install R package dependencies using renv
# We use a temporarily mounted directory to cache build artifacts between
# docker builds and in the end copy it to the original renv cache location
# to not confuse renv when we start runs later.
# Installing piam packages failed for unknown reasons, starting with a
# clean cache folder (hence renv-cache-2) solved it.
RUN --mount=type=cache,target=/tmp/renv-cache-2 \
    RENV_PATHS_CACHE=/tmp/renv-cache-2 \
    RENV_CONFIG_INSTALL_VERBOSE=true \
    Rscript -e '"dummy evaluation to start the renv auto-setup"' && \
    mkdir -p /root/.cache/R/renv/cache && \
    cp -r /tmp/renv-cache-2/* /root/.cache/R/renv/cache/ 2>/dev/null
# cache setup leads to broken symlinks into the cache, but can be fixed with:
RUN Rscript -e "renv::repair()"

# Install GAMS
# Note: GAMS requires a license file. This downloads GAMS but you need to provide your own license.
# The license file (gamslice.txt) should be mounted or copied into the container.
ARG GAMS_VERSION=54.1.0
ARG GAMS_DOWNLOAD_URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMS_VERSION}/linux/linux_x64_64_sfx.exe
RUN cd /tmp && \
    wget -q ${GAMS_DOWNLOAD_URL} -O gams_linux.exe && \
    chmod +x gams_linux.exe && \
    mkdir -p /opt/gams && \
    ./gams_linux.exe -d /opt/gams > /dev/null && \
    rm gams_linux.exe && \
    cp -r /opt/gams/**/* /opt/gams
ENV GAMS_PATH="/opt/gams"
ENV PATH="${GAMS_PATH}:${PATH}"

# Copy GAMS license file if provided
# To use this, you need to have gamslice.txt in the same directory as the Dockerfile
# and uncomment the following line:
# COPY gamslice.txt /opt/gams/gamslice.txt

# Verify installations
RUN echo "Verifying installations..." && \
    git --version && \
    R --version && \
    pandoc --version && \
    tex --version && \
    gams || echo "GAMS installed but may require license activation"

ENV MAGPIE_IMAGE_VERSION="2.0"

# Default command: Start MAgPIE interactively
# Users can run: docker run -it magpie
# Or specify a run script: docker run magpie Rscript start.R default direct
CMD ["bash"]
