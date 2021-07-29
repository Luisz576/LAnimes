const express = require('express')

const SessionController = require('./controllers/SessionController')
const UserController = require('./controllers/UserController')

//router
const routes = express.Router()

//sessions
routes.post('/sessions', SessionController.login)
routes.post('/sessions/new', SessionController.register)

//users
routes.get('/users/:user_id', UserController.userInfo)
routes.get('/users/:user_id/favorites/:am_id', UserController.toggleFavorite)
routes.post('/users/:user_id/genres', UserController.changeGenres)

//export
module.exports = routes