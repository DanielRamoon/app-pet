import { PostgrestError } from "@supabase/supabase-js";
import { HttpStatusCode } from "axios";

export type Omit<T, K extends keyof T> = Pick<T, Exclude<keyof T, K>>;
export type PartialBy<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>;

export interface IServiceResponse<IServiceResultData = unknown> {
	status: HttpStatusCode;
	messages?: string[];
	data?: IServiceResultData;
	trace?: Record<string, any>;
}
