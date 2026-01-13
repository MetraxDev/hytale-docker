FROM eclipse-temurin:25-jdk-jammy

RUN apt update -y; \
    apt upgrade -y; \
    apt install curl unzip -y; \
    mkdir hytale

WORKDIR /hytale

COPY scripts .

RUN curl https://downloader.hytale.com/hytale-downloader.zip -o hytale-downloader.zip; \
    unzip hytale-downloader.zip; \
    rm hytale-downloader.zip

RUN groupadd -g 1000 hytale; \
    useradd -u 1000 -s /sbin/nologin -g hytale hytale; \
    chmod +x run.sh; \
    chown -R 1000:1000 /hytale;

USER 1000:1000

ENTRYPOINT ["./run.sh"]