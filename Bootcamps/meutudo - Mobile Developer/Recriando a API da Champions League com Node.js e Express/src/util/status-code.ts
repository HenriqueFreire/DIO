export enum StatusCode {
    // Respostas de sucesso
    OK = 200,
    CREATED = 201,
    NO_CONTENT = 204,

    // Respostas de redirecionamento
    MOVED_PERMANENTLY = 301,
    SEE_OTHER = 303,

    // Erros do cliente
    BAD_REQUEST = 400,
    UNAUTHORIZED = 401,
    FORBIDDEN = 403,
    NOT_FOUND = 404,
    METHOD_NOT_ALLOWED = 405,
    CONFLICT = 409,

    // Erros do servidor
    INTERNAL_SERVER_ERROR = 500,
    NOT_IMPLEMENTED = 501,
    SERVICE_UNAVAILABLE = 503,
}