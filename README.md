# Scaleway CoreOS builder

Build a CoreOS image from scratch on Scaleway (https://www.scaleway.com/) using
packer.
I'm currently using my own packer builder
(https://github.com/jbonachera/packer-scaleway-plugin) to be able to create
images from scrach.

## Usage

```
cp secrets.example.json secrets.json
vim secrets.json
docker build -t scaleway-coreos-builder .
docker run -it -v $(pwd)/secrets.json:/srv/secrets.json scaleway-coreos-builder
```

A default CoreOS Ignition configuration is burned into the image.
You can change this configuration by mounting your config.yaml at
`/usr/local/src/app/config.yaml`, at run.

It will be transpiled into JSON using https://github.com/coreos/container-linux-config-transpiler.
