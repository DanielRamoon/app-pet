import { HttpStatusCode } from "axios";
import { IServiceResponse } from "types/general";

export default {
	success<T>(data?: T, trace?: Record<string, any>, messages?: string[]): IServiceResponse<T> {
		const response = {} as IServiceResponse<T>;

		response.status = HttpStatusCode.Ok;

		response.data = data;

		if (messages) response.messages = messages;
		if (trace) response.trace = trace;

		return response;
	},

	created<T>(data: T, trace?: Record<string, any>, messages = ["Recurso criado com sucesso!"]): IServiceResponse<T> {
		const response = {} as IServiceResponse<T>;

		response.status = HttpStatusCode.Created;
		response.data = data;

		if (messages) response.messages = messages;
		if (trace) response.trace = trace;

		return response;
	},

	notFound<T>(trace?: Record<string, any>, messages = ["Recurso não encontrado"]): IServiceResponse<T> {
		const response = {} as IServiceResponse<T>;

		response.status = HttpStatusCode.NotFound;
		response.data = undefined;

		if (trace) response.trace = trace;
		if (messages) response.messages = messages;

		return response;
	},

	badRequest<T>(trace?: Record<string, any>, messages = ["Solicitação inválida"]): IServiceResponse<T> {
		const response = {} as IServiceResponse<T>;

		response.status = HttpStatusCode.BadRequest;
		response.data = undefined;

		if (trace) response.trace = trace;
		if (messages) response.messages = messages;

		return response;
	},

	internalServerError<T>(
		trace?: Record<string, any>,
		messages = ["Ocorreu um erro interno no servidor"]
	): IServiceResponse<T> {
		const response = {} as IServiceResponse<T>;

		response.status = HttpStatusCode.InternalServerError;
		response.data = undefined;

		if (trace) response.trace = trace;
		if (messages) response.messages = messages;

		return response;
	},

	unauthorized<T>(trace?: Record<string, any>, messages = ["Não autorizado"]): IServiceResponse<T> {
		const response = {} as IServiceResponse<T>;

		response.status = HttpStatusCode.Unauthorized;
		response.data = undefined;

		if (trace) response.trace = trace;
		if (messages) response.messages = messages;

		return response;
	},
};
