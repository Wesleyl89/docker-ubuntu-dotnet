FROM ubuntu:17.10
MAINTAINER tim@chaubet.be
LABEL dotnet-version="2.1.4"

ENV TZ 'Europe/Brussels'

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && echo $TZ > /etc/timezone \
 && rm /etc/localtime \
 && apt-get install -y net-tools \
                       iputils-ping \
                       curl \
                       wget \
                       unzip \
                       tzdata \
 && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
 && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
 && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-artful-prod artful main" > /etc/apt/sources.list.d/dotnetdev.list' \
 && apt-get update 
 
#RUN wget -q packages-microsoft-prod.deb https://packages.microsoft.com/config/ubuntu/17.10/packages-microsoft-prod.deb \
# && dpkg -i packages-microsoft-prod.deb
 
RUN apt-get install -y dotnet-sdk-2.1.4 \
                       aspnetcore-store-2.0.6 
                       
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
 && dpkg-reconfigure -f noninteractive tzdata \
 && apt-get clean

ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["bash"]
