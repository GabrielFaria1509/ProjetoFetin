# Deploy no Render.com

## Configuração do Backend

### 1. Preparar o repositório
- Faça push do código para um repositório Git (GitHub, GitLab, etc.)

### 2. Criar serviço no Render.com
1. Acesse [render.com](https://render.com) e faça login
2. Clique em "New +" e selecione "Web Service"
3. Conecte seu repositório
4. Configure:
   - **Name**: tism-backend
   - **Environment**: Ruby
   - **Build Command**: `./bin/render-build.sh`
   - **Start Command**: `bundle exec rails server -p $PORT -e production`

### 3. Configurar variáveis de ambiente
Adicione as seguintes variáveis de ambiente no Render:

```
RAILS_ENV=production
RAILS_SERVE_STATIC_FILES=true
RAILS_LOG_TO_STDOUT=true
SECRET_KEY_BASE=<será gerado automaticamente>
RAILS_MASTER_KEY=<copie de config/master.key ou gere novo>
```

### 4. Criar banco de dados PostgreSQL
1. No Render, clique em "New +" e selecione "PostgreSQL"
2. Configure:
   - **Name**: tism-postgres
   - **Database**: tism_production
   - **User**: tism
3. Após criação, copie a `DATABASE_URL` e adicione como variável de ambiente no web service

### 5. Deploy
- O deploy será automático após configuração
- Acesse a URL fornecida pelo Render para testar

## Configuração do Frontend

### Atualizar URL da API
No arquivo `lib/services/user_service.dart`, altere:

```dart
// static const String _baseUrl = 'http://localhost:3000'; // Desenvolvimento
static const String _baseUrl = 'https://seu-app.onrender.com'; // Produção
```

Substitua `seu-app.onrender.com` pela URL real do seu deploy.

## Testando a integração

1. Compile o app Flutter: `flutter build apk`
2. Instale no dispositivo e teste:
   - Registro de usuário (senha mínima 8 caracteres)
   - Login com email e senha
   - Atualização de perfil

## Troubleshooting

### Erro de CORS
Se houver erro de CORS, verifique `config/initializers/cors.rb` e especifique o domínio correto.

### Erro de SSL
O Render.com gerencia SSL automaticamente. Se houver problemas, verifique `config/environments/production.rb`.

### Erro de banco de dados
Verifique se a `DATABASE_URL` está configurada corretamente nas variáveis de ambiente.