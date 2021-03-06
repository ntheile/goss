Goss
=====
Goss  - p2p gossip chat room built on impervious and the Bitcoin Stack
- secure and anonymous chat 
- chat about bets/DLCs , DeFi/derivatives

<img src="./public/images/mask.png" alt="drawing" width="200"/>
<br/>

Impervious.ai Hack for freedom app.

[demo](https://www.youtube.com/watch?v=nC63Y-J_sDM)

<img src="./public/images/goss-chat.png" alt="drawing" width="400"/>
<img src="./public/images/goss-net.png" alt="drawing" width="400"/>


Code: https://github.com/ntheile/goss

Quick Start
==========

1. Setup the IMP and lightning network on polar https://github.com/lispmeister/legendary-fiesta.git. You can import the sample config in `IMPNET.polar.zip`
2. `npm i`
3. `npm run start`
4. open http://localhost:3000

Scripts
========
```bash
# start imp nodes for each federation member
./scripts/run-alice.sh
./scripts/run-bob.sh 
./scripts/run-carol.sh 
./scripts/run-dave.sh
./scripts/run-erin.sh

# run the goss web app
node server.js

# tail the imp logs
tail -f ~/.imp/log.txt | grep "message received"
```

Package Umbrel App
==================
1. Install Umbrel for development https://github.com/getumbrel/umbrel/tree/master/apps
2. Boot Umbrel-dev `cd ../umbrel-dev && umbrel-dev boot`
3. Open the Umbrel dev dashboard at http://umbrel-dev.local 
4. Docker build the Goss app `npm run build` 
5. Push to docker hub `npm run docker-push`
5. Push code to the fork via the instructions here *(in step 3, I used the code below instead) https://github.com/getumbrel/umbrel/tree/master/apps#3-testing-the-app-on-umbrel
```
git remote add ntheile https://github.com/ntheile/umbrel.git 
```
6. `umbrel-dev reload`
7. Open http://umbrel-dev.local:3000/ 
8. `umbrel-dev shutdown`

Imp Commands
============

Alice => Bob
===========

Message 
---------
```
curl --location --request POST '127.0.0.1:8882/v1/message/send' \
--header 'Content-Type: application/json' \
--data-raw '{
    "msg": "hello bobby",
    "pubkey": "0352c618f083ec76ba9b85646b535ad3899dfd213fd8e578a4ddcd40fd6d7aef71",
    "amount": "10"
}'
```

Create Invoice
--------------
```
curl --location --request POST '127.0.0.1:8882/v1/lightning/generateinvoice' \
--header 'Content-Type: application/json' \
--data-raw '{
    "amount": 13,
    "pubkey": "0352c618f083ec76ba9b85646b535ad3899dfd213fd8e578a4ddcd40fd6d7aef71",
    "memo": "Pay me bobby"
}'
```

Federate with Bob
---------------
```
curl --location --request POST '127.0.0.1:8882/v1/federate/request' \
--header 'Content-Type: application/json' \
--data-raw '{
    "pubkey": "0352c618f083ec76ba9b85646b535ad3899dfd213fd8e578a4ddcd40fd6d7aef71"
}'
```

Bob => Alice
===========

Message
--------
```
curl --location --request POST '127.0.0.1:9992/v1/message/send' \
--header 'Content-Type: application/json' \
--data-raw '{
    "msg": "hello alice",
    "pubkey": "02de4a3d885a77960a89d0f31b307f0eec47a25e18126dcddf67ef4212d1f5d788"
}'
```

Pay Invoice
--------------
```
curl --location --request POST '127.0.0.1:9992/v1/lightning/payinvoice' \
--header 'Content-Type: application/json' \
--data-raw '{
    "invoice": "lnbcrt130n1pssa5hhpp5lhqklqqg6vznn9e8e0asg4gmn2mk4wsum4t44cmztzl73u6ps6zsdq52pshjgrdv5sxymmzvfuscqzpgsp5rdgeqmvfy9tzs65hlmrw67s6cshr5efyye2cxqltz8r0hwcm9qcs9qyyssq48puyscf3j3tft9zhd4sx2nzynguysz3tradq2xck9h8tp8wnnmxc6hgsyp8wgh25jm7cgzvqapuw30ux8qttvkjzdfej4h223lansqpyhkylf",
    "pubkey": "02de4a3d885a77960a89d0f31b307f0eec47a25e18126dcddf67ef4212d1f5d788"
}'
```

Federate with Alice
------------------
```
curl --location --request POST '127.0.0.1:9992/v1/federate/request' \
--header 'Content-Type: application/json' \
--data-raw '{
    "pubkey": "02de4a3d885a77960a89d0f31b307f0eec47a25e18126dcddf67ef4212d1f5d788"
}'
```

Todo
====
- Create a blacklist of peers gossiping lies
    - signature check and compare hash of message to majority of peers
    - if the message hash does not match with 2/3 of peers messages. then that peer is speading lies!
    - maybe kick liars out of the federation
    - maybe develop a Reputation Rating Agency
        - could be hard to keep liars out because they could simply rotate public keys
    - maybe the 1 sat per message will be enough to keep the majority of users from spreading fake gossip
- Create a "join-federation.json" spec
    - how do we allow a peer to join a federation?
        - maybe do what hyperleder does and have a signed join file?
        - maybe do what sphinx does and charge a fee to join a tribe?
