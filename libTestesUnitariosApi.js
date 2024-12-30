// Teste 1
// Testes para verificar se a resposta da requisição possui um dos códigos esperados.
/**
 * Testes para verificar se a resposta da requisição possui um dos códigos esperados.
 * @param {object} response - Objeto em formato JSON da resposta.
 * @param {Array} code - Array contendo os códigos aceitos pelo teste.
 */
function codeVerify(response, code) {
    pm.expect(response.code).to.be.oneOf(code)
}

// Testes para verificar se a resposta da requisição possui a estrutura padrão de sucesso
/**
 * Testes para verificar se a resposta da requisição possui a estrutura padrão de sucesso.
 * @param {object} response - Objeto em formato JSON da resposta.
 */
 function successStruct(response) {
    pm.expect(response).to.have.property('data'); // Verifica se a resposta possui o elemento desejado
    pm.expect(response).to.have.nested.property('data.message'); // Verifica se a resposta possui o elemento desejado
    pm.expect(response).to.have.nested.property('data.results'); // Verifica se a resposta possui o elemento desejado
};

// Testes para verificar se a mensagem da resposta da requisição está igual a esperada.
/**
 * Testes para verificar se a mensagem da resposta da requisição está igual a esperada.
 * @param {object} response - Objeto em formato JSON da resposta.
 * @param {string} message - String da mensagem esperada.
 */
function successMessage(response, message) {
    pm.expect(response.data.message).to.be.eql(message);
};

// Testes para verificar se os dados de resultado da resposta estão iguais aos esperados.
/**
 * Testes para verificar se os dados de resultado da resposta estão iguais aos esperados.
 * @param {object} response - Objeto em formato JSON da resposta.
 * @param {Array} results - Array contendo o nome dos campos esperados no results da resposta.
 */
function successResults(response, results) {
    results.forEach((property) => {
        pm.expect(response.data.results).to.have.property(property);
    })
};

// Testes para verificar se a resposta da requisição possui a estrutura padrão de falha.
/**
 * Testes para verificar se a resposta da requisição possui a estrutura padrão de falha.
 * @param {object} response - Objeto em formato JSON da resposta da requisição.
 * @param {boolean} [results=false] - Boolean para indicar se a resposta da requisição deve ter ou não o campo "results" (por padrão, definido como "false").
 */
function failStruct(response, results = false) {
    pm.expect(response).to.have.property('error'); // Verifica se a resposta possui o elemento desejado
    pm.expect(response).to.have.nested.property('error.message'); // Verifica se a resposta possui o elemento desejado
    (results ? pm.expect(response).to.have.nested.property('error.results') : null); // Verifica se a resposta possui o elemento desejado
};

// Testes para verificar se a mensagem da resposta da requisição está igual a esperada.
/**
 * Testes para verificar se a mensagem da resposta da requisição está igual a esperada.
 * @param {object} response - Objeto em formato JSON da resposta.
 * @param {string} message - String da mensagem esperada.
 */
function failMessage(response, message) {
    pm.expect(response.error.message).to.be.eql(message);
};

// Testes para verificar se os dados de resultado da resposta estão iguais aos esperados.
/**
 * Testes para verificar se os dados de resultado da resposta estão iguais aos esperados.
 * @param {object} response - Objeto em formato JSON da resposta.
 * @param {Array} results - Array contendo o nome dos campos esperados no results da resposta.
 */
function failResults(response, results) {
    results.forEach((property) => {
        pm.expect(response.error.results).to.have.property(property);
    })
};

// Função que retorna um request object de leitura (Method GET) baseado na URL e o token de autorização passados.
/**
 * Função que retorna um request object de leitura (Method GET) baseado na URL e o token de autorização passados.
 * @param {string} url - String contendo a URL do endpoint de leitura.
 * @param {string} token - String contendo a token JWT de autorização utilizado no endpoint da requisição.
 * @returns {object} Retorna um request object para ser utilizado no sendRequest().
 */
function requestObjectRead(url, token) {
    return { // Estrutura utilizada para fazer a requisição de leitura para fins de comparação
        url: url, // Endpoint de leitura
        method: 'GET', // Método HTTP utilizado pela leitura
        header: { // Header da requisiçã de leitura
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`, // Uso da token pessoal da Zipdin na requisição
        },
        body: {} // Corpo vazio na leitura
    }
}

// Função que retorna um request object de escrita (Method POST) baseado na URL, token de autorização e body passados.
/**
 * Função que retorna um request object de escrita (Method POST) baseado na URL, token de autorização e body passados.
 * @param {string} url - String contendo a URL do endpoint de escrita.
 * @param {string} token - String contendo a token JWT de autorização utilizado no endpoint da requisição.
 * @param {JSON} body - Objeto JSON contendo o body da requisição.
 * @returns {object} Retorna um request object para ser utilizado no sendRequest().
 */
function requestObjectCreate(url, token, body) {
    return { // Estrutura utilizada para fazer a requisição de leitura para fins de comparação
        url: url, // Endpoint de leitura
        method: 'POST', // Método HTTP utilizado pela leitura
        header: { // Header da requisiçã de leitura
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`, // Uso da token pessoal da Zipdin na requisição
        },
        body: {
            mode: 'raw',
            raw: JSON.stringify(body)
        }
    }
}

// Função para realizar o login de um usuário e retorna a token deste login.
/**
 * Função que realiza o login de um usuário e retorna a token deste login.
 * @param {string} user - String contendo o nome de usuário para utilizar no login.
 * @param {string} psswd - String contendo a senha do usuário para utilizar no login.
 * @param {string} url - String contendo a URL para onde se deseja realizar o login.
 * @param {string} code - String contendo o código de Two Factor Authentication. Por padrão é utilizado o valor "000000"
 * @returns {string} Retorna um string contendo o token do login do usuário.
 */
async function getTokenFromLogin(user, psswd, url, code = "000000") {
    let firstRequest = requestObjectCreate(url, "", {"username":user, "password":psswd})
    await pm.sendRequest(firstRequest)
    let secondRequest = requestObjectCreate(url, "", {"username":user, "password":psswd, "code":code})
    const responseObject = await pm.sendRequest(secondRequest)
    return responseObject.json().jwtToken
}
