const { invalid_params, user_not_founded } = require('../configs/errors_id.json')
const User = require('../models/User')

module.exports = {
    async userInfo(req, res){
        const { user_id } = req.params
        //validação
        if(!user_id) return res.json({ error_id: invalid_params, error_message: "O user_id não foi passado" })
        let user = await User.findById(user_id)
        if(!user) return res.json({ error_id: user_not_founded, error_message: "user_id inválido" })
        //Info do usuário
        //PS: Não retorne senhas
        return res.json({
            sucess: 200,
            user: {
                username: user.username,
                genres: user.genres,
                favorites: user.favorites
            }
        })
    },
    async changeGenres(req, res){
        const { user_id } = req.params
        const { genres } = req.body
        //validação
        if(!user_id) return res.json({ error_id: invalid_params, error_message: "O user_id não foi passado" })
        let user = await User.findById(user_id)
        if(!user) return res.json({ error_id: user_not_founded, error_message: "user_id inválido" })
        //troca dos genres
        user.genres = genres ? genres.split(',').map(genre => { return genre.trim() }) : []
        await user.save()
        //sucesso
        return res.json({
            sucess: 200,
            user: {
                genres: user.genres
            }
        })
    }
    ,
    async toggleFavorite(req, res){
        const { user_id, am_id } = req.params
        //validação
        if(!user_id) return res.json({ error_id: invalid_params, error_message: "O user_id não foi passado" })
        if(!am_id) return res.json({ error_id: invalid_params, error_message: "Nenhum id foi passado" })
        let user = await User.findById(user_id)
        if(!user) return res.json({ error_id: user_not_founded, error_message: "user_id inválido" })
        //toggle favorite
        let added = false
        if(user.favorites.includes(`${am_id}`))
            user.favorites = user.favorites.filter(favorite => favorite !== `${am_id}`)
        else{
            added = true
            user.favorites = [...user.favorites, `${am_id}`]
        }
        await user.save()
        //sucesso
        return res.json({
            sucess: 200,
            user: {
                favorites: user.favorites
            },
            removed: !added,
            added,
        })
    },
}