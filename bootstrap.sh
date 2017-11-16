#!/bin/bash

locs=(usa eu hk jp in br)
declare -A A2P
# ?=SHA256	stratum+tcp://sha256.eu.nicehash.com:3334
A2P[scrypt]=stratum+tcp://scrypt.eu.nicehash.com:3333
# ?=ScryptN	stratum+tcp://scryptnf.eu.nicehash.com:3335
# ?=ScryptJaneNf16	stratum+tcp://scryptjanenf16.eu.nicehash.com:3348
# X11=Dash	stratum+tcp://x11.eu.nicehash.com:3336
A2P[x11]=stratum+tcp://x11.eu.nicehash.com:3336
A2P[x13]=stratum+tcp://x13.eu.nicehash.com:3337
A2P[keccak]=stratum+tcp://keccak.eu.nicehash.com:3338
A2P[x15]=stratum+tcp://x15.eu.nicehash.com:3339
A2P[nist5]=stratum+tcp://nist5.eu.nicehash.com:3340
A2P[neoscrypt]=stratum+tcp://neoscrypt.eu.nicehash.com:3341
A2P[lyra2re]=stratum+tcp://lyra2re.eu.nicehash.com:3342
A2P[whirlpoolx]=stratum+tcp://whirlpoolx.eu.nicehash.com:3343
A2P[qubit]=stratum+tcp://qubit.eu.nicehash.com:3344
A2P[quark]=stratum+tcp://quark.eu.nicehash.com:3345
A2P[axiom]=stratum+tcp://axiom.eu.nicehash.com:3346
A2P[lyra2rev2]=stratum+tcp://lyra2rev2.eu.nicehash.com:3347
# blakecoin=Blake256r8	stratum+tcp://blake256r8.eu.nicehash.com:3349
A2P[blakecoin]=stratum+tcp://blake256r8.eu.nicehash.com:3349
# ?=Blake256r14	stratum+tcp://blake256r14.eu.nicehash.com:3350
# vanilla=VCash=Blake256r8vnl	stratum+tcp://blake256r8vnl.eu.nicehash.com:3351
A2P[vanilla]=stratum+tcp://blake256r8vnl.eu.nicehash.com:3351
A2P[hodl]=stratum+tcp://hodl.eu.nicehash.com:3352
# ?=DaggerHashimoto	stratum+tcp://daggerhashimoto.eu.nicehash.com:3353
A2P[decred]=stratum+tcp://decred.eu.nicehash.com:3354
A2P[cryptonight]=stratum+tcp://cryptonight.eu.nicehash.com:3355
A2P[lbry]=stratum+tcp://lbry.eu.nicehash.com:3356
# ?=Equihash	stratum+tcp://equihash.eu.nicehash.com:3357
# ?= Pascal	stratum+tcp://pascal.eu.nicehash.com:3358
# x11gost=SibCoin=X11Gost	stratum+tcp://x11gost.eu.nicehash.com:3359
A2P[11gost]=stratum+tcp://x11gost.eu.nicehash.com:3359
# ?= Sia	stratum+tcp://sia.eu.nicehash.com:3360

if [[ $# == 0 ]]; then
  if [[ -z $POOL ]]; then
    locs_closer=($({ for loc in "${locs[@]}"; do p="${A2P[$ALGO]/LOC/$loc}"; echo "$(ping -c 3 -i 0.3 "${p%:*}" | grep min/avg/max/stddev | perl -pe's!.* ([\d\.]+)/([\d\.]+)/.*!$2!') $loc" & done; wait; } | sort -n | awk '{print $2}'))
    POOL="${A2P[$ALGO]/LOC/${locs_closer[0]}}"
  fi
  #cpu_cnt=$(grep ^processor /proc/cpuinfo | wc -l)
  USERNAME=${USERNAME:-$WALLET.${WORKER:-$HOSTNAME}}
  PASSWORD=${PASSWORD:-x}
  set -- -a "$ALGO" -o "$POOL" -u "$USERNAME" -p "$PASSWORD"
fi
exec nice -n 18 cpuminer "$@"
