FROM ubuntu:18.04
MAINTAINER tim@chaubet.be
LABEL dotnet-version="2.1.4"

ENV TZ 'Europe/Brussels'

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && echo $TZ > /etc/timezone \
 && apt-get install -y net-tools \
                       iputils-ping \
                       curl \
                       wget \
                       unzip \
                       tzdata \
                       gpg \
 && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
 && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
 && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-artful-prod artful main" > /etc/apt/sources.list.d/dotnetdev.list' \
 && apt-get update 

RUN curl http://ftp.de.debian.org/debian/pool/main/i/icu/libicu57_57.1-6+deb9u2_amd64.deb -o libicu57_57.1-6+deb9u2_amd64.deb \
 && dpkg -i libicu57_57.1-6+deb9u2_amd64.deb
 
RUN apt-get install -y dotnet-sdk-2.1.4 \
                       aspnetcore-store-2.0.6 
                       
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
 && dpkg-reconfigure -f noninteractive tzdata \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["bash"]
