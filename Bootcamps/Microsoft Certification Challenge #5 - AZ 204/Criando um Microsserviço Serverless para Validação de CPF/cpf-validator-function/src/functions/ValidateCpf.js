const { app } = require('@azure/functions');

app.http('ValidateCpf', {
    methods: ['GET', 'POST'],
    authLevel: 'anonymous',
    handler: async (request, context) => {
        context.log(`Http function processed request for url "${request.url}"`);

        const cpf = request.query.get('cpf') || (await request.text()) || '';
        let isValid = false;

        if (cpf) {
            isValid = validateCpf(cpf);
        }

        return { jsonBody: { cpf: cpf, isValid: isValid } };
    }
});

function validateCpf(cpf) {
    cpf = cpf.replace(/[^\d]+/g, ''); // Remove non-digit characters

    if (cpf.length !== 11 || /^(\d)\1{10}$/.test(cpf)) {
        return false;
    }

    let sum = 0;
    let remainder;

    // Validate first digit
    for (let i = 1; i <= 9; i++) {
        sum += parseInt(cpf.substring(i - 1, i)) * (11 - i);
    }
    remainder = (sum * 10) % 11;

    if ((remainder === 10) || (remainder === 11)) {
        remainder = 0;
    }
    if (remainder !== parseInt(cpf.substring(9, 10))) {
        return false;
    }

    sum = 0;
    // Validate second digit
    for (let i = 1; i <= 10; i++) {
        sum += parseInt(cpf.substring(i - 1, i)) * (12 - i);
    }
    remainder = (sum * 10) % 11;

    if ((remainder === 10) || (remainder === 11)) {
        remainder = 0;
    }
    if (remainder !== parseInt(cpf.substring(10, 11))) {
        return false;
    }

    return true;
}

