import { StatusCode } from "./status-code";
import { HttpResponse } from "../models/httpResponse-model";

export const ok = async (data: any): Promise<HttpResponse> => {
    return {
        statusCode: StatusCode.OK,
        body: data,
    };
};

export const noContent = async (): Promise<HttpResponse> => {
    return {
        statusCode: StatusCode.NO_CONTENT,
        body: {message: "id not found"},
    };
};

export const created = async (): Promise<HttpResponse> => {
    return {
        statusCode: StatusCode.CREATED,
        body: {message: "Created successful"},
    };
};

export const badRequest = async (): Promise<HttpResponse> => {
    return {
        statusCode: StatusCode.BAD_REQUEST,
        body: {message: "Bad request"},
    };
};

export const okDelete = async (): Promise<HttpResponse> => {
    return {
        statusCode: StatusCode.OK,
        body: {message: "Delete successful"},
    };
};
