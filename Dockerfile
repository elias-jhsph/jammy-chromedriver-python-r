FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

ADD . /

RUN apt update && \
    apt install curl wget unzip -y && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get install -fy && \
    CHROMEDRIVER_VERSION=$(curl -sS "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_114") && \
    wget https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/bin && \
    chmod +x /usr/bin/chromedriver

RUN apt install python3-launchpadlib python3.11-venv -y && \
    python3.11 -m venv env && \
    . env/bin/activate && \
    python3.11 -m pip install -r requirements.txt

RUN apt install --no-install-recommends software-properties-common dirmngr gpg-agent default-jre default-jdk -y && \
    wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
    add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" -y && \
    apt install --no-install-recommends r-base -y

RUN add-apt-repository ppa:c2d4u.team/c2d4u4.0+ -y && \
    for pkg in $(awk '{ print "r-cran-" tolower($0) }' packages.txt); \
    do apt install -y $pkg || echo "Failed to install $pkg"; \
    done && \
    Rscript --vanilla install2.R
