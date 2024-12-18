create policy "Give authenticated users access to own files" on storage.objects
    as permissive
    for select
    using ((bucket_id = 'avatars'::text) AND (auth.role() = 'authenticated'::text) AND (auth.uid() = owner));

create policy "Give authenticated users the control their own files" on storage.objects
    as permissive
    for delete
    using ((bucket_id = 'avatars'::text) AND (auth.role() = 'authenticated'::text) AND (auth.uid() = owner));

create policy "Give authenticated users the possibility to upload files" on storage.objects
    as permissive
    for insert
    with check ((bucket_id = 'avatars'::text) AND (auth.role() = 'authenticated'::text));

create policy "Give user the possibility to update own avatar file" on objects
    as permissive
    for update
    using ((bucket_id = 'avatars'::text) AND (storage.filename(name) = concat((auth.uid())::text, '.png')) AND (auth.uid() = owner));