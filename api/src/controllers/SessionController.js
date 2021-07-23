const { invalid_params, user_already_exists, user_or_password_incorrect } = require('../configs/errors_id.json')
const { parcial_tokens } = require('../configs/parcial_tokens.json')
const User = require('../models/User')

function _tokenGenerate(){
    const token_start = parcial_tokens[Math.floor(Math.random() * parcial_tokens.length)]
    const token_end = parcial_tokens[Math.floor(Math.random() * parcial_tokens.length)]
    return `${token_start}${Date.now()}${token_end}`
}

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
        //Na hora da criação, é bom encriptografar a senha para caso haja um vazamento de dados do banco de dados
        user = await User.create({ username, password })
        return res.json({
            success: 200,
            message: "Usuário criado com sucesso",
            user: {
                username: user.username,
            }
        })
    },
    async login(req, res){
        const { token } = req.headers
        const { username, password } = req.body
        if(!username) return res.json({ error_id: invalid_params, error_message: "Nome de usuário ou senha não foram informados" })
        if(!password && !token) return res.json({ error_id: invalid_params, error_message: "Nome de usuário ou senha não foram informados" })
        let user = await User.findOne({ username })
        //Na hora de recuperar, caso se tenha encriptografado a senha, utiliza-se a mesma criptografia na senha e compara os resultados
        if(user){
            if(password)
                if(user.password === password){
                    //Um novo token é gerado cada vez que se realiza login, assim, deslogando de outro dispositivou
                    //Esse token será usado em todas as requisições, "garantindo" que o usuário logou no app
                    user.token = _tokenGenerate()
                    await user.save()
                    return res.json({
                        success: 200,
                        user: {
                            user_id: user._id,
                            username: user.username,
                            token: user.token,
                        }
                    })
                }
            if(token)
                if(user.token === token){
                    return res.json({
                        success: 200,
                        user: {
                            user_id: user._id,
                            username: user.username,
                            token,
                        }
                    })
                }
        }
        return res.json({ error_id: user_or_password_incorrect, error_message: "Usuário ou/e senha incorreto(s)" })
    },
}