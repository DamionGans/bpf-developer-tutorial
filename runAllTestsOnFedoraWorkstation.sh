#! /bin/bash
sudo dnf install llvm
sudo dnf install clang
wget https://aka.pw/bpf-ecli -O ecli && chmod +x ./ecli
wget https://github.com/eunomia-bpf/eunomia-bpf/releases/latest/download/ecc && chmod +x ./ecc
cd src/1-helloworld/
../../ecc minimal.bpf.c
../../ecli run package.json
cd ../2-kprobe-unlink/
../../ecc minimal.bpf.c
../../ecli run package.json &
ecli_pid=$!
sleep 2 && touch test1 && rm test1 && touch test2 && rm test2
kill $ecli_pid
# the rest needs to be done still.. For now just boilerplate
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
