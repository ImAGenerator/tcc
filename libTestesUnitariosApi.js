// Testes para verificar se a resposta da requisição possui um dos códigos esperados.
/**
 * Testes para verificar se a resposta da requisição possui um dos códigos esperados.
 * @param {object} response - Objeto em formato JSON da resposta.
 * @param {Array} code - Array contendo os códigos aceitos pelo teste.
 */
function codeVerify(response, code) {
    pm.test(`Resposta possui um dos códigos: ${code}`, function () {
        pm.expect(response.code).to.be.oneOf(code)
    })
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
    pm.test('Resposta possui a mensagem esperada', function () {
        pm.expect(response.data.message).to.be.eql(message);
    });
};

function successResults(response, results) {
    results.forEach((property) =>
        pm.test(`Resposta possui a propriedade results.${property}`, function () {
            pm.expect(response.data.results).to.have.property(property);
        })
    );
};

// Testes para verificar se a resposta da requisição possui a estrutura padrão de falha.
/**
 * Testes para verificar se a resposta da requisição possui a estrutura padrão de falha.
 * @param {object} response - Objeto em formato JSON da resposta da requisição.
 * @param {boolean} [results=false] - Boolean para indicar se a resposta da requisição deve ter ou não o campo "results" (por padrão, definido como "false").
 */
function failStruct(response, results = false) {
    pm.test(`Resposta possui a estrutura padrão de sucesso`, function () { // Função de teste
        pm.expect(response).to.have.property('error'); // Verifica se a resposta possui o elemento desejado
        pm.expect(response).to.have.nested.property('error.message'); // Verifica se a resposta possui o elemento desejado
        (results ? pm.expect(response).to.have.nested.property('error.results') : null); // Verifica se a resposta possui o elemento desejado
    });
};

// Testes para verificar se as propriedades e valores do objeto "response" incluem todas as propriedades e valores do objeto "request".
/**
 * Testes para verificar se as propriedades e valores do objeto "response" incluem todas as propriedades e valores do objeto "request".
 * @param {JSON} request - Objeto em formato JSON da requisição enviada.
 * @param {JSON} response - Objeto em formato JSON da resposta da requisição em formato padrão para ser comparado.
 */
function compareValuesRequestResponse (request, response) {
    const requestProperties = Object.keys(request)
    const requestValues = Object.values(request)
    for (let variable = 0; variable < baseProperties.length; variable++) { // Laço para testar todas as variáveis enviadas
        pm.test(`A variável ${requestProperties[variable]} foi corretamente inserida na tabela`, function () { // Função de teste
            pm.expect(response.data.results[requestProperties[variable]]).to.be.eql(requestValues[variable]);
        });
    }
}

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

module.exports = {
    codeVerify,
    successStruct,
    successMessage,
    //successResults,
    failStruct,
    compareValuesRequestResponse,
    requestObjectRead,
    requestObjectCreate
    };
// Use module.exports to export the functions that should be
// available to use from this package.
// module.exports = { <your_function> }

// Once exported, use this statement in your scripts to use the package.
// const myPackage = pm.require('<package_name>')