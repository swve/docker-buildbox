#!/bin/sh

echo "Starting ..."

echo "Updating packages using sources :"
cat /etc/apt/sources.list
apt-get -qq clean -qq && apt-get -qq update

echo "Install base"
apt-get -qq -y install build-essential curl git make openssh-client jq unzip groff less
echo "Done Install base!"

echo "Install CI Helper"
curl -sSL https://github.com/rande/gitlab-ci-helper/releases/download/${CI_HELPER_VERSION}/linux-amd64-gitlab-ci-helper -o /usr/bin/ci-helper
chmod 755 /usr/bin/ci-helper
echo "Done Install CI Helper"

echo "Installing AWS CLIv2" 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
unzip awscliv2.zip
./aws/install 
echo "Done installing awscliv2!"

echo "Install graphviz"
apt-get -qq -y install graphviz
echo "Done Install graphviz!"

echo "Install postgresql-client"
apt-get -qq -y install postgresql-client
echo "Done Install postgresql-client!"

echo "Cleaning files!"
rm -rf /tmp/*
apt-get -y remove --purge dpkg-dev fakeroot file manpages manpages-dev patch xauth xz-utils
apt-get -qq -y autoremove
apt-get -qq clean && apt-get -qq purge
rm -rf /var/lib/apt/lists/* /var/lib/dpkg/*-old
rm -rf /usr/share/doc /usr/share/locale/[a-df-z]* /usr/share/locale/e[a-lo-z]* /usr/share/locale/en@* /usr/share/locale/en_GB

echo "Done!"
