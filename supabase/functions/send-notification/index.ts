// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

serve(async (req) => {
	const { to, title, body } = await req.json();

	const sent = await fetch("https://exp.host/--/api/v2/push/send", {
		method: "POST",
		headers: {
			"Content-Type": "application/json",
			Accept: "application/json",
			"Accept-encoding": "gzip, deflate",
		},
		body: JSON.stringify({
			to,
			title,
			body,
		}),
	});

	return new Response(JSON.stringify(await sent.json()), { headers: { "Content-Type": "application/json" } });
});

// To invoke:
// curl -i --location --request POST 'http://localhost:54321/functions/v1/' \
//   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
//   --header 'Content-Type: application/json' \
//   --data '{"to": "", "title": "Hello", "body": "World"}'

/* 
curl --request POST 'https://bmmnhexzqjvnujrwwgoy.supabase.co/functions/v1/send-notification' --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImprbHplZ2llamVpYWlvcGlib21vIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjE0NTIwNDEsImV4cCI6MTk3NzAyODA0MX0.TREvrcecIT2JC87Fvr9BJaWsvPy4yxEn6UGcPoinATk' --header 'Content-Type: application/json' --data '{"to": "ExponentPushToken[LyBARgEGe-XF9nZ0VK5Zjf]", "title": "Hello", "body": "World"}'
*/

// Kovinski access-token: sbp_e076a918bee9fb921e5b5463c18f6330eb4ce2eb
