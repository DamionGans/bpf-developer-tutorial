#! /bin/bash
sudo dnf install -y clang elfutils-libelf elfutils-libelf-devel zlib-devel llvm
If [-f /usr/bin/ecli]; then
echo "ecli installed"
Else
wget https://aka.pw/bpf-ecli -O ecli && chmod +x ./ecli && sudo mv ecli /usr/bin/.
Fi
If [-f /usr/bin/ecc]; then
echo "ecli installed"
Else
wget https://github.com/eunomia-bpf/eunomia-bpf/releases/latest/download/ecc && chmod +x ./ecc && sudo mv ecli /usr/bin/.
Fi

cd src/1-helloworld/
ecc minimal.bpf.c
sudo ecli run package.json &
$minmal = $!
sleep 1
kill $minimal
cd ../2-kprobe-unlink/
ecc kprobe-unlink.bpf.c
sudo ecli run package.json &
kprobe_unlink=$!
sleep 1 && touch test1 && rm test1 && touch test2 && rm test2
kill $kprobe_unlink
cd ../3-fentry-unlink/
ecc fentry-unlink.bpf.c
sudo ecli run package.json &
fentry_unlink=$!
sleep 1 && touch test1 && rm test1 && touch test2 && rm test2 
kill $fentry_unlink
cd ../4-opensnoop
ecc opensnoop.bpf.c
sudo ecli run package.json &
$opensnoop=$!
sleep 1
kill $opensnoop
cd ../5-uprobe-bashreadline/
ecc bashreadline.bpf.c
sudo ecli run package.json &
$bashreadline=$!
kill $!
cd ../6-sigsnoop/
ecc sigsnoop.bpf.c
sudo ecli run package.json &
$sigsnoop=$!
sleep 1
kill $sigsnoop
cd ../7-execsnoop
ecc execsnoop.bpf.c execsnoop.h
sudo ecli run package.json &
$execsnoop=$!
sleep 1
kill $execsnoop
