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

function requestObjectLogin(url, body) {
    return { // Estrutura utilizada para fazer a requisição de leitura para fins de comparação
        url: url, // Endpoint de leitura
        method: 'POST', // Método HTTP utilizado pela leitura
        header: { // Header da requisiçã de leitura
            'Content-Type': 'application/json',
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
 * @param {string} code - String contendo o código de Two Factor Authentication. Por padrão é utilizado o valor "000000"
 * @returns {string} Retorna um string contendo o token do login do usuário.
 */
async function getTokenFromLogin(user, psswd, code = "000000") {
    let codeRequest = requestObjectLogin('https://hml.zipdin.com.br/zipdin-base/services/login/authorize', {"clientId":user, "codeChallenge": "sLA4ScispiRAneofzg8CtQeq7WQqNRpTpRVomH-As3E", "codeChallengeMethod": "S256"});
    const codeLogin = await pm.sendRequest(codeRequest);
    const authorizationCode = codeLogin.json().data.results.code;
    let firstRequest = requestObjectLogin('https://hml.zipdin.com.br/zipdin-base/services/login/perform_v2', {"username":user, "password":psswd, "authorizationCode":authorizationCode, "codeVerifier":"KqL6c9SNDVZwzJYDdWtlKqarfc_K9tUIniwH70wgbfk"});
    const firstLogin = await pm.sendRequest(firstRequest);
    let secondRequest = requestObjectLogin('https://hml.zipdin.com.br/zipdin-base/services/login/perform_v2', {"username":user, "password":psswd, "authorizationCode":authorizationCode, "codeVerifier":"KqL6c9SNDVZwzJYDdWtlKqarfc_K9tUIniwH70wgbfk", "code":code});
    const responseObject = await pm.sendRequest(secondRequest);
    return responseObject.json().jwtToken;
}

// Função que retorna a data de validade de um token JWT.
/**
 * 
 */
function getTokenExpirationDate(token) {
    // Divide o token em três partes: cabeçalho, corpo e assinatura
    const parts = token.split('.');

    if (parts.length !== 3) {
        throw new Error('Token inválido');
    }

    // A parte do corpo (payload) é a segunda parte
    const payload = parts[1];

    // Decodifica a parte do corpo do token de base64 URL para base64
    const base64Url = payload.replace(/-/g, '+').replace(/_/g, '/');
    const base64 = base64Url + '='.repeat((4 - base64Url.length % 4) % 4);
    
    // Converte de base64 para JSON
    const jsonPayload = JSON.parse(atob(base64));

    // Verifica se o campo "exp" existe
    if (!jsonPayload.exp) {
        throw new Error('Campo "exp" não encontrado no token');
    }

    // A data de expiração está no formato de timestamp em segundos, então converte para milissegundos
    return new Date(jsonPayload.exp * 1000); // Retorna um objeto Date
}
