#! /bin/bash
sudo dnf install clang elfutils-libelf elfutils-libelf-devel zlib-devel llvm
wget https://aka.pw/bpf-ecli -O ecli && chmod +x ./ecli
wget https://github.com/eunomia-bpf/eunomia-bpf/releases/latest/download/ecc && chmod +x ./ecc
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json &
$minmal = $!
sleep 1
kill $minimal
cd ../2-kprobe-unlink/
../../ecc kprobe-unlink.bpf.c
../../ecli run package.json &
kprobe_unlink=$!
sleep 1 && touch test1 && rm test1 && touch test2 && rm test2
kill $kprobe_unlink
cd ../3-fentry-unlink/
../../ecc fentry-unlink.bpf.c
../../ecli run package.json &
fentry_unlink=$!
sleep 1 && touch test1 && rm test1 && touch test2 && rm test2 
kill $fentry_unlink
cd ../4-opensnoop
../../ecc opensnoop.bpf.c
../../ecli run package.json &
$opensnoop=$!
sleep 1
kill $opensnoop
cd ../5-uprobe-bashreadline/
../../ecc bashreadline.bpf.c
../../ecli run package.json &
$bashreadline=$!
kill $!
cd ../6-sigsnoop/
../../ecc sigsnoop.bpf.c
../../ecli run package.json &
$sigsnoop=$!
sleep 1
kill $sigsnoop
cd ../7-execsnoop
../../ecc execsnoop.bpf.c execsnoop.h
../../ecli run package.json &
$execsnoop=$!
sleep 1
kill $execsnoop
# the rest needs to be done still.. For now just boilerplate
cd ../1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
