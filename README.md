# xrdp-fedora

This image provides xrdp desktop based on Fedora.

This image contains:
 - Fedora based environment
 - MATE desktop
 - xrdp server (for remote desktop)
 - Firefox
 - auto user creation script

# Building image

You can use build.sh script to build image localy. If You want to do a custom build you're free to do that.

# Running container based on this image

To run container You simply need to run this command:

```sh
$ docker run -p 3389:3389 -e USER=john -itd xrdp-fedora
```

This command will create user 'john' with sudo and expose port 3389 (RDP) to connect to. Default password is 'passwordxrdp'.
You can pick any user name by simply changing 'john' to other user name. If You  also want to change default password You can use PASSWD env:

```sh
$ docker run -p 3389:3389 -e USER=john -e PASSWD=johnpassword -itd xrdp-fedora
```

Container will create docker volume as /home directory. All settings and data except password will be preserved until all containers using this volume will be removed.
For persistent storage it is recommended to pass host directory as /home to container:

```sh
$ docker run -p 3389:3389 -e USER=john -e PASSWD=johnpassword -v /home/john/xrdp-home:/home -itd xrdp-fedora
```

## Optional

Docker will limit some applications like gdb to point that functionality of those applications will be broken. There is a need to increase container functionality by adding few parameters like '--cap-add=SYS_PTRACE --security-opt seccomp=unconfined':

```sh
$ docker run -p 3389:3389 -e USER=john -e PASSWD=johnpassword --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v /home/john/xrdp-home:/home -itd xrdp-fedora
```

For better stability / memory managment in applications like Firefox it is a good idea to increase shared memory for container by adding -v /dev/shm:/dev/shm:

```sh
$ docker run -p 3389:3389 -e USER=john -e PASSWD=johnpassword -v /dev/shm:/dev/shm -v /home/john/xrdp-home:/home -itd xrdp-fedora
```

For better performance you can add more cpu resources to docker using --cpus=... (double value where each 1.0 is one cpu).
For example value 3.5 will give a three and a half "cpus" to container.

```sh
$ docker run --cpus=3.5 -p 3389:3389 -e USER=john -e PASSWD=johnpassword -v /dev/shm:/dev/shm -v /home/john/xrdp-home:/home -itd xrdp-fedora
```

# Connecting

If container is running You can simply use any remote desktop client with RDP support (Remmina, xfreerdp, native Windows client, etc.) simply by connecting to host on specified port (default port for RDP is 3389).

Inside container is a ssh server but is not started. You can start it manualy or modify entrypoint.sh to start server automaticaly. VNC like ssh is installed but not started except when used by xrdp.

# Issues
 - Google Chrome is needing some kind of workaround to work in container otherwise will not start - not implemented
