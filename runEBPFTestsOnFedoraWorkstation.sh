#! /bin/bash
if [ "$EUID" -ne 0 ]
then echo "Please run as root (sudo)"
exit
fi
sudo dnf install -y clang elfutils-libelf elfutils-libelf-devel zlib-devel llvm
if [ -f /usr/bin/ecli ]; then
  echo "ecli installed"
else
wget https://aka.pw/bpf-ecli -O ecli && chmod +x ./ecli && sudo mv ecli /usr/bin/
fi
if [ -f /usr/bin/ecc ]; then
echo "ecc installed"
else
wget https://github.com/eunomia-bpf/eunomia-bpf/releases/latest/download/ecc -O ecc && chmod +x ./ecc && sudo mv ecc /usr/bin/
fi
cd src/1-helloworld/
ecc minimal.bpf.c
ecli run package.json &
minimal=$!
sleep 1
kill $minimal
cd ../2-kprobe-unlink/
ecc kprobe-link.bpf.c
ecli run package.json &
kprobe=$!
sleep 1 && touch test1 && rm -rf test1 && touch test2 && rm -rf test2
kill $kprobe
cd ../3-fentry-unlink/
ecc fentry-link.bpf.c
ecli run package.json &
fentry=$!
sleep 1 && touch test1 && rm -rf test1 && touch test2 && rm -rf test2 
kill $fentry
cd ../4-opensnoop
ecc opensnoop.bpf.c
ecli run package.json &
opensnoop=$!
sleep 1
kill $opensnoop
cd ../5-uprobe-bashreadline/
ecc bashreadline.bpf.c
ecli run package.json &
bashreadline=$!
kill $!
cd ../6-sigsnoop/
ecc sigsnoop.bpf.c
ecli run package.json &
sigsnoop=$!
sleep 1
kill $sigsnoop
cd ../7-execsnoop
ecc execsnoop.bpf.c execsnoop.h
ecli run package.json &
execsnoop=$!
sleep 1
kill $execsnoop
cd ../8-exitsnoop
ecc exitsnoop.bpf.c exitsnoop.h
ecli run package.json &
exitsnoop=$!
sleep 1
kill $execsnoop
cd ../9-runqlat
ecc hardirqs.bpf.c
ecli run package.json &
hardirqs=$!
sleep 2
kill $hardirqs
cd ../10-hardirqs
ecc hardirqs.bpf.c
ecli run package.json &
hardirqs=$!
sleep 2
kill $hardirqs
cd ../11-bootstrap
make
chmod +x bootstrap
./bootstrap &
bootstrap=$!
sleep 2
kill $bootstrap
cd ../12-profile
ecc profile.bpf.c
ecli run package.json &
profile=$!
kill $profile
