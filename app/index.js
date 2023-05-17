const express = require('express');
const app = express();
const { read, write } = require('./FileManager');

app.use(express.json());

app.get('/', (req, res) => {
    read(res);
}
);

app.post('/', (req, res) => {
    let name = req.body.name;
    let age = req.body.age;
    let data = { name, age };

    write(data, res);
}
);

app.listen(3000, () => console.log('Listening on port 3000...'));
