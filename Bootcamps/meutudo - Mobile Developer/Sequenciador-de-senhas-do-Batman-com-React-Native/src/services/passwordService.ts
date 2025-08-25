export function generatePass(passwordLength: number = 8): string {
    const UPPERCASE_CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const LOWERCASE_CHARS = 'abcdefghijklmnopqrstuvwxyz';
    const NUMBER_CHARS = '0123456789';
    const SYMBOL_CHARS = '!@#$%^&*()_+<>:?{}[]';
    const ALL_CHARS = UPPERCASE_CHARS + LOWERCASE_CHARS + NUMBER_CHARS + SYMBOL_CHARS;

    // Garantir que o comprimento da senha seja de no mínimo 4, para incluir todos os tipos de caracteres
    const effectiveLength = Math.max(passwordLength, 4);

    let password = '';
    let requiredChars: string[] = [];

    // Adiciona um caractere de cada tipo para garantir a robustez
    requiredChars.push(UPPERCASE_CHARS.charAt(Math.floor(Math.random() * UPPERCASE_CHARS.length)));
    requiredChars.push(LOWERCASE_CHARS.charAt(Math.floor(Math.random() * LOWERCASE_CHARS.length)));
    requiredChars.push(NUMBER_CHARS.charAt(Math.floor(Math.random() * NUMBER_CHARS.length)));
    requiredChars.push(SYMBOL_CHARS.charAt(Math.floor(Math.random() * SYMBOL_CHARS.length)));

    // Preenche o restante da senha com caracteres aleatórios
    for (let i = 4; i < effectiveLength; i++) {
        requiredChars.push(ALL_CHARS.charAt(Math.floor(Math.random() * ALL_CHARS.length)));
    }

    // Embaralha o array para evitar que a senha siga um padrão previsível (ex: sempre começar com maiúscula)
    for (let i = requiredChars.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [requiredChars[i], requiredChars[j]] = [requiredChars[j], requiredChars[i]];
    }

    password = requiredChars.join('');

    return password;
}