FROM rocker/rstudio:3.4.0

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
    vim \
    libgdal-dev \
    libproj-dev \
    libxml2-dev

# Add working directory for proceeding commands
WORKDIR /home/rstudio

# Add and RUN install packages
ADD packages.R .
RUN Rscript packages.R

# Clone GitHub repo
RUN git clone https://github.com/ropensci/rrricanes.git

# Change ownership of all files to rstudio
RUN chown -R rstudio:rstudio .

# Change default shell for user rstudio
RUN chsh -s /bin/bash rstudio
