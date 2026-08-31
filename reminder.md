# SEAPATH Build Reminder

Sur `charlie`, exécuter les commandes suivantes.

```bash
ssh charlie
cd ~/seapath
```

## 1. Recréer les sources kernel

```bash
cqfd run /home/cwenger/seapath/build.sh -v \
  --distro seapath-guest \
  --machine seapath-vm-arm64 \
  -- bitbake -f -c unpack virtual/kernel
```

## 2. Recréer l'arbre kernel partagé

```bash
cqfd run /home/cwenger/seapath/build.sh -v \
  --distro seapath-guest \
  --machine seapath-vm-arm64 \
  -- bitbake -f -c shared_workdir virtual/kernel
```

## 3. Rejouer le lien si `kernel-source` est vide

```bash
cqfd run /home/cwenger/seapath/build.sh -v \
  --distro seapath-guest \
  --machine seapath-vm-arm64 \
  -- bitbake -f -c symlink_kernsrc virtual/kernel
```

## 4. Vérifier le kernel source

```bash
ls -l build/tmp/work-shared/seapath-vm-arm64/kernel-source/Makefile
```

Le fichier `Makefile` doit exister.

## 5. Tester `make-mod-scripts`

```bash
cqfd run /home/cwenger/seapath/build.sh -v \
  --distro seapath-guest \
  --machine seapath-vm-arm64 \
  -- bitbake -f -c configure make-mod-scripts
```

## 6. Relancer l'image

```bash
cqfd run /home/cwenger/seapath/build.sh -v \
  -i seapath-guest-efi-image \
  --distro seapath-guest \
  --machine seapath-vm-arm64
```

Important : faire `cd ~/seapath` avant `cqfd run`. Ne pas utiliser `-C` avec cette configuration.
