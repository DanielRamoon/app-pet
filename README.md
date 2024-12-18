# PETVIDADE

## CHAVES IMPORTANTES

MAPS-IOS-API-KEY AIzaSyDEn7ZIPLS3FXkyAHqwX2scLGJV87agzKI

MAPS-ANDROID-API-KEY AIzaSyD6E_WdfxaCvzjZATZlho9uvCs06R4HEQA

## Fazer um dump do schema remoto para um arquivo local (PowerShell)

```bash
npx supabase db dump -f supabase/schemas/schema-$(date -Format yyyy-MM-dd-HH-mm-ss).prod.sql
```

## Baixar todos os dados da produção

```bash
npx supabase db dump -f supabase/seeds/seed-$(date -Format yyyy-MM-dd-HH-mm-ss).prod.sql --data-only
```

## Criar migration após a alteração do schema

```bash
npx supabase db diff --use-migra -f migration_name
```

## Subir migrations para produção

```bash
npx supabase db push
```
