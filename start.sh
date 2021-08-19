# start imp nodes for each federation member
./scripts/run-alice.sh
./scripts/run-bob.sh 
./scripts/run-carol.sh 
./scripts/run-dave.sh
./scripts/run-erin.sh

# run the goss web app
npm run start

# tail the imp logs
tail -f ~/.imp/log.txt | grep "message received"