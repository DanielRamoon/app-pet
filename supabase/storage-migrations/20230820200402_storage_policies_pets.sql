create policy "Give users permission to view own pet photos" on storage.objects
    as permissive
    for select
    to authenticated
    using ((bucket_id = 'pets'::text) AND ((storage.foldername(name))[1] = 'photos'::text) AND
           (((storage.foldername(name))[2])::uuid = auth.uid()) AND (auth.role() = 'authenticated'::text));

create policy "Give users permission to upload own pet photo" on storage.objects
    as permissive
    for insert
    to authenticated
    with check ((bucket_id = 'pets'::text) AND ((storage.foldername(name))[2] = 'photos'::text) AND
                ((auth.uid())::text = (storage.foldername(name))[3]));

create policy "Give users permission to update own pet photo" on storage.objects
    as permissive
    for update
    to authenticated
    using (bucket_id = 'pets')
    with check (((storage.foldername(name))[2])::uuid = auth.uid());

create policy "Give users permission to delete own pet photo" on storage.objects
    as permissive
    for delete
    to authenticated
    using ((bucket_id = 'pets'::text) AND ((storage.foldername(name))[2] = 'photos'::text) AND
           ((storage.foldername(name))[3] = (auth.uid())::text));