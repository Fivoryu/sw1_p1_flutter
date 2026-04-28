# AWS deployment

Este repositorio queda preparado para desplegar la version web de Flutter en Amazon S3 + CloudFront.

## Recursos AWS necesarios

- Un bucket S3 para el build web
- Una distribucion CloudFront
- Un rol IAM para GitHub Actions con permisos sobre S3 y CloudFront

## Variables de GitHub Actions

Configura estas `Repository variables`:

- `AWS_REGION`
- `S3_BUCKET`
- `CLOUDFRONT_DISTRIBUTION_ID`

Configura estos `Repository secrets`:

- `AWS_ROLE_ARN`
- `API_BASE_URL`: URL publica del backend Spring Boot, por ejemplo `https://api.tudominio.com`
- `GRAPHQL_URL`: URL publica de GraphQL, por ejemplo `https://api.tudominio.com/api/graphql`

## Flujo de despliegue

- Cada push a `main` ejecuta `.github/workflows/aws-deploy.yml`
- El workflow compila la version web con `dart-define`
- Despues publica `build/web` en S3 e invalida la cache de CloudFront

## Nota para SPA

En CloudFront conviene mapear errores `403` y `404` a `/index.html` con codigo `200` para soportar rutas internas.
