#! /bin/bash
if [ "$EUID" -ne 0 ]
then echo "Please run as root (sudo)"
exit
fi
sudo dnf install -y clang elfutils-libelf elfutils-libelf-devel zlib-devel llvm cargo
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
sleep 5
kill $execsnoop
cd ../8-exitsnoop
ecc exitsnoop.bpf.c exitsnoop.h
ecli run package.json &
exitsnoop=$!
sleep 1
kill $exitsnoop
cd ../9-runqlat
ecc runqlat.bpf.c runqlat.h
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
git submodule update --init --recursive
make
chmod +x bootstrap
./bootstrap &
bootstrap=$!
sleep 2
kill $bootstrap
cd ../12-profile
git submodule update --init --recursive
make
chmod +x profile
./profile &
profile=$!
sleep 3
kill $profile
cd ../13-tcpconnlat
make
chmod +x tcpconnlat
./tcpconnlat &
tcpconnlat=$!
sleep 3
kill $tcpconnlat
cd ../14-tcpstates
ecc tcprtt.bpf.c tcprtt.h
ecli run package.json &
tcpstates=$!
sleep 3
kill $tcpstates
cd ../15-javagc
make
chmod +x javagc
./javagc -p 12345 &
javagc=$!
sleep 1
kill $javagc
cd ../16-memleak
make
chmod +x memleak
./memleak &
memleak=$!
sleep 4
kill $memleak
cd ../17-biopattern
make
chmod +x biopattern
./biopattern &
biopattern=$!
sleep 4
kill $biopattern
cd ../19-lsm-connect
ecc lsm-connect.bpf.c
ecli run package.json &
lsmconnect=$!
sleep 1 ; ping 1.1.1.1 -c 4
kill $lsmconnect
cd ../20-tc
ecc tc.bpf.c
ecli run package.json &
tc=$!
sleep 2
kill $tc
