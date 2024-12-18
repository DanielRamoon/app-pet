create policy "Allow delete if user_id matches auth.uid()"
    on vaccines_doses
    for delete
    using (
    (SELECT TRUE
     FROM vaccines_doses vd
              JOIN health_vaccines hv ON vd.vaccine_id = hv.id
              JOIN pets_health ph ON hv.health_id = ph.id
              JOIN pets p ON ph.pet_id = p.id
     WHERE hv.id = vd.vaccine_id
       AND p.user_id = auth.uid())
    );

create policy "Allow update if user_id matches auth.uid()"
    on vaccines_doses
    for update
    using (
    (SELECT TRUE
     FROM vaccines_doses vd
              JOIN health_vaccines hv ON vd.vaccine_id = hv.id
              JOIN pets_health ph ON hv.health_id = ph.id
              JOIN pets p ON ph.pet_id = p.id
     WHERE hv.id = vd.vaccine_id
       AND p.user_id = auth.uid())
    );

create policy "Allow create if pet_id matches user_id"
    on vaccines_doses
    for insert
    with check (
    exists (SELECT 1
            FROM vaccines_doses vd
                     JOIN health_vaccines hv ON vd.vaccine_id = hv.id
                     JOIN pets_health ph ON hv.health_id = ph.id
                     JOIN pets p ON ph.pet_id = p.id
            WHERE hv.id = vd.vaccine_id
              AND p.user_id = auth.uid())
    );


create policy "Allow select for associated user"
    on vaccines_doses
    for select
    using (
    exists (SELECT 1
            FROM vaccines_doses vd
                     JOIN health_vaccines hv ON vd.vaccine_id = hv.id
                     JOIN pets_health ph ON hv.health_id = ph.id
                     JOIN pets p ON ph.pet_id = p.id
            WHERE hv.id = vd.vaccine_id
              AND p.user_id = auth.uid())
    );
