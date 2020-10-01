FROM rocker/r-ver:3.6.2

RUN mkdir /home/magpie
COPY . /home/magpie/

RUN apt-get update \
 && apt-get install -y libpng-dev \
 && apt-get install -y libjpeg-dev \
 && apt-get install -y zlib1g-dev \
 && apt-get install -y pkg-config \
 && apt-get install -y libssl-dev \
 && apt-get install -y libxml2-dev \
 && apt-get install -y libcurl4-openssl-dev \
 && apt-get install -y curl \
 && apt-get install -y texlive \
 && apt-get install -y fonts-inconsolata \
 && apt-get install -y pandoc \
 && apt-get install -y pandoc-citeproc \
 && fc-cache -fv




RUN R -e "options(repos = \
  list(CRAN = 'https://cran.rstudio.com/',pik='https://rse.pik-potsdam.de/r/packages')); \
  install.packages(c('gdxrrw', \
           'ggplot2', \
           'curl', \
           'gdx', \
           'magclass', \
           'madrat', \
           'mip', \
           'lucode2', \
           'magpie4', \
           'magpiesets', \
           'lusweave', \
           'luscale', \
           'goxygen', \
           'luplot'))"

# Set GAMS version
ENV LATEST=30.3.0
ENV GAMS_VERSION=${LATEST}

# Set GAMS bit architecture, either 'x64_64' or 'x86_32'
ENV GAMS_BIT_ARC=x64_64


# Download GAMS
RUN curl -SL "https://d37drm4t2jghv5.cloudfront.net/distributions/${LATEST}/linux/linux_${GAMS_BIT_ARC}_sfx.exe" --create-dirs -o /opt/gams/gams.exe

# Install GAMS
RUN cd /opt/gams &&\
    chmod +x gams.exe; sync &&\
    cp /home/magpie/gamslice.txt . &&\
    ./gams.exe &&\
    rm -rf gams.exe

COPY gamslice.txt /opt/gams/gams30.3_linux_x64_64_sfx/gamslice.txt
# Add GAMS path to user env path
RUN GAMS_PATH=$(dirname $(find / -name gams -type f -executable -print)) &&\
    ln -s $GAMS_PATH /usr/local/bin &&\
    echo "export PATH=\$PATH:$GAMS_PATH" >> ~/.bashrc &&\
    cd $GAMS_PATH &&\
    ./gamsinst -a

COPY gamslice.txt /opt/gams/gams30.3_linux_x64_64_sfx/gamslice.txt

CMD  cd /home/magpie && Rscript start.R
