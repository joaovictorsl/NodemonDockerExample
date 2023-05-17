const fs = require('fs');

function write(data, res) {
    fs.writeFile('/data/data.json', JSON.stringify(data), (err) => {
        let answer = '';

        if (err) answer = err.message;
        else answer = 'Data written to file';

        res.send(answer);
    }
    );
}

function read(res) {
    fs.readFile('/data/data.json', (err, buff) => {
        let answer = '';

        if (err) answer = err.message;
        else {
            let data = buff.toString();
            answer = JSON.parse(data);
        }

        res.send(answer);
    }
    );
}

module.exports = { read, write };
