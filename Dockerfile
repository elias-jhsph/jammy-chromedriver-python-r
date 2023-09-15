FROM rocker/verse:latest-daily

ENV DEBIAN_FRONTEND=noninteractive

ADD . /

RUN apt update && \
    apt install curl wget -y && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get install -fy && \
    CHROMEDRIVER_VERSION=$(curl -sS "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_114") && \
    wget https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/bin && \
    chmod +x /usr/bin/chromedriver

RUN apt-get install python3-launchpadlib -y && \
    apt install python3.11-venv -y && \
    python3.11 -m venv env && \
    . env/bin/activate && \
    python3.11 -m pip install -r requirements.txt

RUN apt install -y default-jre default-jdk r-cran-rjava librsvg2-dev gsl-bin libgsl-dev libcurl4-openssl-dev libxml2 libxml2-dev libssl-dev libharfbuzz-dev libfribidi-dev libv8-dev libpoppler-cpp-dev && \
    R CMD javareconf && \
    Rscript --vanilla install2.R
