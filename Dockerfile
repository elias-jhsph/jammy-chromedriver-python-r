FROM rocker/base:4.3.1

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

RUN apt install -y python3.11-venv software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    update-alternatives --install /usr/bin/python python3 /usr/bin/python3.11 10 && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.11 get-pip.py && \
    python3.11 -m venv env && \
    . env/bin/activate && \
    python3.11 -m pip install -r requirements.txt

RUN apt install -y default-jre default-jdk r-cran-rjava librsvg2-dev gsl-bin libgsl-dev && \
    R CMD javareconf && \
    Rscript --vanilla install2.R
