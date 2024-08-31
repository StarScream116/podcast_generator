FROM ubuntu:latest

# Add deadsnakes PPA for Python 3.10
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y python3.10 python3.10-venv python3-pip git

# Create and activate virtual environment
RUN python3.10 -m venv /opt/venv

# Install dependencies inside the virtual environment
RUN /opt/venv/bin/pip install PyYAML

# Ensure that the virtual environment is used by default
ENV PATH="/opt/venv/bin:$PATH"

COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
