FROM ubuntu:20.04

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG USERNAME=ptlx

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y sudo git bash software-properties-common build-essential curl file python-setuptools ruby \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get install -y curl

# adduser ${USERNAME}:${USERNAME} with password '${USERNAME}'
RUN groupadd -g 1000 ${USERNAME} \
    && useradd -g ${USERNAME} -G sudo -m -s /bin/bash ${USERNAME} \
    && echo "${USERNAME}:${USERNAME}" | chpasswd

RUN echo "Defaults visiblepw" >> /etc/sudoers
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}
WORKDIR /home/${USERNAME}/
CMD ["/bin/bash"]