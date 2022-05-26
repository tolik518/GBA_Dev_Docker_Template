FROM devkitpro/devkita64

ARG uid

RUN dkp-pacman -S --noconfirm gba-dev && \
    useradd -d /developer -m -u $uid developer && \
    chown -R $uid /developer

ENV HOME=/developer
ENV DEVKITPRO=/opt/devkitpro
ENV DEVKITARM=/opt/devkitpro/devkitARM

USER developer
WORKDIR /developer
VOLUME /developer

CMD make