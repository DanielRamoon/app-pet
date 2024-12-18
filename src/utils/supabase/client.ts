import AsyncStorage from "@react-native-async-storage/async-storage";
import { createClient } from "@supabase/supabase-js";
import { Database } from "types/supabase";
import env from "environment";
import "react-native-url-polyfill/auto";

export const supabase = createClient<Database>(env.SUPABASE_URL, env.SUPABASE_KEY, {
	// localStorage: AsyncStorage as any,
	// detectSessionInUrl: false, // Previne o Supabase de tentar usar window.location.href, o que quebra o funcionamento em dispositivos móveis.
	auth: {
		storage: AsyncStorage as any,
		persistSession: true,
		autoRefreshToken: true,
		detectSessionInUrl: false,
	},
});

export async function logOut() {
	const { error } = await supabase.auth.signOut();

	if (error) {
		alert(error.message);
	}
}
