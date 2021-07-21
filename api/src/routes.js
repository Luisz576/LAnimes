const express = require('express')

//router
const routes = express.Router()

//temp get
routes.get('/', (_req, res) => {
    return res.json({ connected: true })
})

//export
module.exports = routes