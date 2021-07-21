const { invalid_params, user_already_exists, user_or_password_incorrect } = require('../configs/errors_id.json')
const User = require('../models/User')

module.exports = {
    async register(req, res){
        const { username, password } = req.body
        //Validações
        if(!(username && password)) return res.json({ error_id: invalid_params, error_message: "Nome de usuário ou senha não foram passados" })
        if(!(username.length >= 6 && password.length >= 8)) return res.json({ error_id: invalid_params, error_message: "Nome de usuário ou senha muito curtos" })
        if(!(username.length <= 16 && password.length <= 20)) return res.json({ error_id: invalid_params, error_message: "Nome de usuário ou senha muito longos" })
        //Usuario
        let user = await User.findOne({ username })
        if(user) return res.json({ error_id: user_already_exists, error_message: "Usuário já existente" })
        //Na hora da criação, para evitar problemas com vazamento de dados, pode-se encriptografar a senha
        user = await User.create({ username, password })
        return res.json({
            sucess: 200,
            message: "Usuário criado com sucesso",
            user: {
                username: user.username,
            }
        })
    },
    async login(req, res){
        const { username, password } = req.body
        if(!(username && password)) return res.json({ error_id: invalid_params, error_message: "Nome de usuário ou senha não foram passados" })
        let user = await User.findOne({ username })
        //Na hora de recuperar, caso se tenha encriptografado a senha, utiliza-se a mesma criptografia na senha e compara os resultados
        if(user)
            if(user.password == password){
                //Você pode criar um token ou id de validação para as requisições, tornando assim o aplicativo mais seguro, mas nesse caso, o nosso id será o mesmo que o _id do mongo
                return res.json({
                    sucess: 200,
                    user: {
                        user_id: user._id,
                        username: user.username
                    }
                })
            }
        return res.json({ error_id: user_or_password_incorrect, error_message: "Usuário ou/e senha incorreto(s)" })
    },
}