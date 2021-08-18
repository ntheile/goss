const express = require('express')
const app = express()
const port = 3000;
const path = require('path');
const axios = require('axios');
const bodyParser = require('body-parser');


app.use(express.static('public'))
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(bodyParser.raw());


app.get('/', function (req, res) {
    res.sendfile('public/index.html');
});

// POST method route
app.post('/send', async function (req, res) {

    let retry = 0;
    const {msg, pubkey, amount, port} = req.body;

    try {
        let r = await sendMsg(msg, pubkey, amount, port);
        return res.json(r.data);
    } catch (e){
        retry++;
        console.log("retry...attempt " + retry);
        if (retry < 4){
            let r = await sendMsg(msg, pubkey, amount, port);
            return res.json(r.data);
        } else {
            return res.json(e);
        }
    }
});

async function sendMsg(msg, pubkey, amount, port){
    const json = JSON.stringify({
        msg, //"msg": "hello bobby, from alice",
        pubkey, //"pubkey": "0352c618f083ec76ba9b85646b535ad3899dfd213fd8e578a4ddcd40fd6d7aef71",
        amount //"amount": "10"
    });
    const r = await axios.post(`http://127.0.0.1:${port}/v1/message/send`, json, {
        headers: {
            // Overwrite Axios's automatically set Content-Type
            'Content-Type': 'application/json'
        }
    });
    return r;
}

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})