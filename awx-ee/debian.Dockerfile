FROM debian:bullseye-slim

RUN apt update \
&& apt install -y \
sudo \
python3.9 \
python3-pip \
nano \
curl \
ssh \
git

COPY requirements.txt requirements.txt
COPY ansible.cfg /etc/ansible/ansible.cfg

RUN pip install -r requirements.txt

RUN useradd -ms /bin/bash ansible
USER ansible
WORKDIR /home/ansible

COPY requirements.yml /home/ansible/requirements.yml
