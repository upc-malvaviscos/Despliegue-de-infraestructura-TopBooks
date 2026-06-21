# TopBooks Infra (Equipo 1)

## Integrantes

- Santiago Oliver Suriñach (@surinyach)
- Renato Luzuriaga (@orLuzuriaga)
- Martí Fabregat Pous (@raati5674)
- Anyul Rivas (@anyulled)

## Estructura

```text
.
├── .github/
│   └── workflows/
│       └── terraform-ci.yml
├── src/
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── networking.tf
│   ├── security_group.tf
│   ├── rds.tf
│   ├── web_server.tf
│   └── storage.tf
└── .gitignore
```

## Pipeline (CI)

El workflow ejecuta en cada `push` y `pull_request`:

1. `terraform init -backend=false` en `src/`
2. `terraform fmt -check -recursive`
3. `terraform validate` en `src/`

## Variables y secretos de GitHub Actions

El despliegue manual del workflow requiere configurar estos secretos en GitHub:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_SESSION_TOKEN` (solo para credenciales temporales)
- `DB_USER_NAME`
- `DB_PASSWORD`

La variable de repositorio `TF_VAR_group_name` es opcional y utiliza `equipo1` por defecto.
