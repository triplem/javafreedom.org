var lunr = require('lunr')
require("lunr-languages/lunr.stemmer.support")(lunr)
require('lunr-languages/lunr.multi')(lunr)
require("lunr-languages/lunr.de")(lunr)

var stdin = process.stdin,
    stdout = process.stdout,
    buffer = []

stdin.resume()
stdin.setEncoding('utf8')

stdin.on('data', function (data) {
    buffer.push(data)
})

stdin.on('end', function () {
    var documents = JSON.parse(buffer.join(''))

    var idx = lunr(function () {
        this.ref('id')
        this.field('title')
        this.field('content')

        documents.forEach(function (doc) {
            this.add(doc)
        }, this)
    })

    stdout.write(JSON.stringify(idx))
})
