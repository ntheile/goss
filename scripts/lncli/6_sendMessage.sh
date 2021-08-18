curl --location --request POST '127.0.0.1:8882/v1/message/send' \
--header 'Content-Type: application/json' \
--data-raw '{
    "msg": "hello ridgeback, its nicktee",
    "pubkey": "0284aeb7562c1982a333cade20f75f364bb113b1c917ff8e5d65dff5a74148f1d1"
}'


# carol => alice
curl --location --request POST '127.0.0.1:9994/v1/message/send' \
--header 'Content-Type: application/json' \
--data-raw '{
    "msg": "hello alice, its  carol",
    "pubkey": "02de4a3d885a77960a89d0f31b307f0eec47a25e18126dcddf67ef4212d1f5d788",
    "amount": "1"
}'

curl --location --request POST '127.0.0.1:29992/v1/message/send' \
--header 'Content-Type: application/json' \
--data-raw '{
    "msg": "msg",
    "pubkey": "02de4a3d885a77960a89d0f31b307f0eec47a25e18126dcddf67ef4212d1f5d788"
}'