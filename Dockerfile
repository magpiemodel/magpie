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

FROM ubuntu:24.04

# Install system dependencies (before WORKDIR to maximize cache hits)
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
  apt update && DEBIAN_FRONTEND=noninteractive apt install -y \
    # We do not want a minimal image, as we want to use this interactively
    unminimize \
    # Basic tools
    wget \
    curl \
    git \
    unzip \
    # Build tools
    build-essential \
    cmake \
    # R and dependencies
    r-base \
    r-base-dev \
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
    # Pandoc
    pandoc \
    # Other utilities
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install GAMS
# Note: GAMS requires a license file. This downloads GAMS but you need to provide your own license.
# The license file (gamslice.txt) should be mounted or copied into the container.
ARG GAMS_VERSION=51.3.0
ARG GAMS_DOWNLOAD_URL=https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMS_VERSION}/linux/linux_x64_64_sfx.exe

# Download and install GAMS
RUN cd /tmp && \
    wget -q ${GAMS_DOWNLOAD_URL} -O gams_linux.exe && \
    chmod +x gams_linux.exe && \
    mkdir -p /opt/gams && \
    ./gams_linux.exe -d /opt/gams > /dev/null && \
    rm gams_linux.exe && \
    cp -r /opt/gams/**/* /opt/gams

# Add GAMS to PATH
ENV GAMS_PATH="/opt/gams"
ENV PATH="${GAMS_PATH}:${PATH}"


# Copy GAMS license file if provided
# To use this, you need to have gamslice.txt in the same directory as the Dockerfile
# and uncomment the following line:
# COPY gamslice.txt /opt/gams/gamslice.txt

# Set up R package manager pak
ENV RSPM='https://packagemanager.posit.co/cran/__linux__/noble/latest'
ENV RENV_CONFIG_REPOS_OVERRIDE='https://packagemanager.posit.co/cran/__linux__/noble/latest'
RUN <<EOF 
echo "options(repos = c(pikpiam = 'https://pik-piam.r-universe.dev',
                        CRAN = Sys.getenv('RSPM')))" > ~/.Rprofile
EOF

RUN Rscript -e 'install.packages("pak")'
RUN Rscript -e 'pak::pkg_install("languageserver")'

# Set working directory
WORKDIR /opt/magpie

# Clone the MAgPIE project
RUN git clone --depth=1 https://github.com/magpiemodel/magpie.git .

# Install R package dependencies using renv
# We use a temporarily mounted directory to cache build artifacts between
# docker builds and in the end copy it to the original renv cache location
# to not confuse renv when we start runs later.
RUN --mount=type=cache,target=/tmp/renv-cache \
    RENV_PATHS_CACHE=/tmp/renv-cache \
    RENV_CONFIG_INSTALL_VERBOSE=true \
    RENV_CONFIG_PAK_ENABLED=true \
    Rscript -e '"dummy evaluation to start the renv auto-setup"' && \
    mkdir -p /root/.cache/R/renv/cache && \
    cp -r /tmp/renv-cache/* /root/.cache/R/renv/cache/ 2>/dev/null

# Verify installations
RUN echo "Verifying installations..." && \
    git --version && \
    R --version && \
    pandoc --version && \
    tex --version && \
    gams || echo "GAMS installed but may require license activation"

# Set environment variables
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Default command: Start MAgPIE interactively
# Users can run: docker run -it magpie
# Or specify a run script: docker run magpie Rscript start.R default direct
CMD ["bash"]
