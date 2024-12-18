import { PostgrestError } from "@supabase/supabase-js";
import { HttpStatusCode as StatusCodes } from "axios";

export default interface IRequestResponse<Body, E> {
	data?: Body;
	status?: string | StatusCodes;
	error?: PostgrestError | null | E;
	message?: string;
}
