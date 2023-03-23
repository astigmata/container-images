FROM debian:bullseye-slim

ARG USERNAME=ansible

RUN apt update \
&& apt install -y \
sudo \
python3.9 \
python3-pip \
nano \
curl \
ssh \
git \
unzip \
software-properties-common \
apt-transport-https

COPY pip/requirements.txt requirements.txt
COPY ansible.cfg /etc/ansible/ansible.cfg

RUN pip install -r requirements.txt

RUN curl https://baltocdn.com/helm/signing.asc | apt-key add - \
&& echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
&& apt-get update && apt-get install -y --no-install-recommends helm

RUN useradd -ms /bin/bash ${USERNAME}
USER ${USERNAME}
WORKDIR /home/${USERNAME}

COPY collections/requirements.yml /home/ansible/requirements.yml
