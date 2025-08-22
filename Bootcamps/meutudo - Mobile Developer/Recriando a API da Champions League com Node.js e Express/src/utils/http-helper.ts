import { HttpResponse } from '../models/status-code-model'

export const ok = async (data: any): Promise<HttpResponse> => {
  return {
    statusCode: 200,
    body: data
  }
}

export const created = async (data: any): Promise<HttpResponse> => {
  return {
    statusCode: 201,
    body: data
  }
}

export const noContent = async (): Promise<HttpResponse> => {
  return {
    statusCode: 204,
    body: null
  }
}

export const badRequest = async (error: Error): Promise<HttpResponse> => {
  return {
    statusCode: 400,
    body: { error }
  }
}