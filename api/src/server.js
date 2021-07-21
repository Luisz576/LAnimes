const { port, mongodb_atlas } = require('./configs/server_configs.json')
const express = require('express')
const mongoose = require('mongoose')
const routes = require('./Routes')

//server
const app = express()

//mongodb connection
mongoose.connect(mongodb_atlas, {
    useNewUrlParser: true,
    useUnifiedTopology: true
})

//uses
app.use(express.json())
app.use(routes)

//listener
app.listen(port)