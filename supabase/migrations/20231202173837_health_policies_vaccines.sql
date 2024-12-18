create policy "Allow delete if user_id matches auth.uid()"
    on health_vaccines
    for delete
    using (
    (select true
     from pets_health ph
              join
          pets p
          on
              ph.pet_id = p.id
     where p.user_id = auth.uid())
    );

create policy "Allow update if user_id matches auth.uid()"
    on health_vaccines
    for update
    using (
    (select true
     from pets_health ph
              join
          pets p
          on
              ph.pet_id = p.id
     where p.user_id = auth.uid())
    );

create policy "Allow create if pet_id matches user_id"
    on health_vaccines
    for insert
    with check (
    exists (select 1
            from pets_health ph
                     join pets p on ph.pet_id = p.id
            where p.user_id = auth.uid())
    );


create policy "Allow select for associated user"
    on health_vaccines
    for select
    using (
    exists (select 1
            from pets_health ph
                     join pets p on ph.pet_id = p.id
            where p.user_id = auth.uid())
    );
