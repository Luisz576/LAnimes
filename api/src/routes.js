const express = require('express')

const SessionController = require('./controllers/SessionController')
const UserController = require('./controllers/UserController')

//router
const routes = express.Router()

//sessions
routes.post('/sessions/register', SessionController.register)
routes.post('/sessions/login', SessionController.login)

//users
routes.get('/users/:user_id', UserController.userInfo)
routes.get('/users/:user_id/favorite/:am_id', UserController.toggleFavorite)
routes.post('/users/:user_id/genres', UserController.changeGenres)

//export
module.exports = routes