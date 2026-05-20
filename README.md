# TopBooks Infra (Equipo 1)

Base mínima del proyecto para el entregable de Terraform en AWS.

## Integrantes

- Santi
- Renato Luzuriaga (@orLuzuriaga)
- Martí Fabregat Pous (@raati5674)
- Anyul Rivas (@anyulled)

## Estructura

```text
.
├── .github/workflows/terraform-ci.yml
├── src
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   └── variables.tf
└── .gitignore
```

## Pipeline (CI)

El workflow ejecuta en cada `push` y `pull_request`:

1. `terraform init -backend=false` en `src/`
2. `terraform fmt -check -recursive`
3. `terraform validate` en `src/`
