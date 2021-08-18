./scripts/run-alice.sh
./scripts/run-bob.sh 
./scripts/run-carol.sh 
./scripts/run-dave.sh
./scripts/run-erin.sh
npm run start

tail -f ~/.imp/log.txt | grep "message received"