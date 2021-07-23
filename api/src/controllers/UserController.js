const { invalid_params, access_blocked, user_not_founded } = require('../configs/errors_id.json')
const User = require('../models/User')

module.exports = {
    async userInfo(req, res){
        const { token } = req.headers
        const { user_id } = req.params
        //validação
        if(!user_id) return res.json({ error_id: invalid_params, error_message: "O user_id não foi passado" })
        if(!token) return res.json({ error_id: access_blocked, error_message: "Acesso negado" })
        let user = await User.findById(user_id)
        if(!user) return res.json({ error_id: user_not_founded, error_message: "user_id inválido" })
        if(user.token !== token) return res.json({ error_id: access_blocked, error_message: "Acesso negado" })
        //Info do usuário
        //PS: Não retorne senhas
        return res.json({
            success: 200,
            user: {
                username: user.username,
                genres: user.genres,
                favorites: user.favorites,
                token, //RETORNA PRO APP O TOKEN PASSADO QUE TEORICAMENTE É VÁLIDO
            }
        })
    },
    async changeGenres(req, res){
        const { token } = req.headers
        const { user_id } = req.params
        const { genres } = req.body
        //validação
        if(!user_id) return res.json({ error_id: invalid_params, error_message: "O user_id não foi passado" })
        if(!token) return res.json({ error_id: access_blocked, error_message: "Acesso negado" })
        let user = await User.findById(user_id)
        if(!user) return res.json({ error_id: user_not_founded, error_message: "user_id inválido" })
        if(user.token !== token) return res.json({ error_id: access_blocked, error_message: "Acesso negado" })
        //troca dos genres
        user.genres = genres ? genres.split(',').map(genre => { return genre.trim() }) : []
        await user.save()
        //sucesso
        return res.json({
            success: 200,
        })
    }
    ,
    async toggleFavorite(req, res){
        const { token } = req.headers
        const { user_id, am_id } = req.params
        //validação
        if(!token) return res.json({ error_id: access_blocked, error_message: "Acesso negado" })
        if(!user_id) return res.json({ error_id: invalid_params, error_message: "O user_id não foi passado" })
        if(!am_id) return res.json({ error_id: invalid_params, error_message: "Nenhum id foi passado" })
        let user = await User.findById(user_id)
        if(!user) return res.json({ error_id: user_not_founded, error_message: "user_id inválido" })
        if(user.token !== token) return res.json({ error_id: access_blocked, error_message: "Acesso negado" })
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
            success: 200,
            removed: !added,
            added,
        })
    },
}