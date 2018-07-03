# chrsh
Mock configuration for Chromium to build, test and run in a chroot environment.

This repo provides a [Mock](https://github.com/rpm-software-management/mock) configuration file and bash function to isolate the Chromium build environment and ease the interaction with.



## Setup

### Mock
```
sudo dnf install mock
sudo usermod -a -G mock [User name]
newgrp -
```

### chrsh
```
git clone https://github.com/rsclarke/chrsh.git
cd chrsh
sudo cp chromium.cfg /etc/mock
cat .bashrc >> ~/.bashrc
source ~/.bashrc
mkdir ~/chromium
mock -r chromium init
```

## Building Chromium

### Install `depot_tools` and Fetch Chromium Source

```
chrsh git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
chrsh "echo export PATH=\$PATH:\${HOME}/depot_tools >> ~/.bashrc"
chrsh cd chromium \&\& fetch --nohooks --no-history chromium
chrsh cd chromium/src \&\& gclient runhooks
```

### Update `/etc/mock/chromium.cfg`

After the inital setup above, most of the time you will be executing commands within the `chromium/src` directory.  Therefore it is recommended to uncomment the line indicated in `/etc/mock/chromium.cfg`

```
# Additional arguments to supply to systemd-nspawn
config_opts['nspawn_args'] = [
        "--setenv=DISPLAY={}".format(os.getenv("DISPLAY")),
        "--chdir={}".format(_home),
# Uncomment the following line to enable chrsh to jump straight to chromium/src
#       "--chdir={}".format(os.path.join(_home, 'chromium', 'src'))
]
```

### Compile Chromium

```
chrsh gn gen out/Default
chrsh ninja -C out/Default chrome
```

