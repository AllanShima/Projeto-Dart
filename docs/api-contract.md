# GeoQuest — Contrato da API REST

> **Base URL:** `https://api.geoquest.app/v1`  
> **Autenticação:** Bearer Token em todas as rotas autenticadas (`Authorization: Bearer <token>`)  
> **Formato:** `Content-Type: application/json` / `Accept: application/json`

---

## Recursos

### 1. Autenticação (`/auth`)

---

#### `POST /auth/register`

Cria uma nova conta de usuário. Rota pública.

**Corpo da requisição:**

```json
{
  "name": "João Silva",
  "email": "joao@email.com",
  "password": "Senha123"
}
```

**Resposta de sucesso — `201 Created`:**

```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "user": {
    "id": "usr_abc123",
    "name": "João Silva",
    "email": "joao@email.com",
    "created_at": "2024-03-10T10:00:00.000Z"
  }
}
```

**Respostas de erro:**

| Código | Situação                     |
| ------ | ---------------------------- |
| 409    | E-mail já cadastrado         |
| 422    | Campos inválidos ou ausentes |
| 500    | Erro interno do servidor     |

---

#### `POST /auth/login`

Autentica um usuário existente. Rota pública.

**Corpo da requisição:**

```json
{
  "email": "joao@email.com",
  "password": "Senha123"
}
```

**Resposta de sucesso — `200 OK`:**

```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "user": {
    "id": "usr_abc123",
    "name": "João Silva",
    "email": "joao@email.com",
    "created_at": "2024-03-10T10:00:00.000Z"
  }
}
```

**Respostas de erro:**

| Código | Situação                   |
| ------ | -------------------------- |
| 401    | E-mail ou senha incorretos |
| 500    | Erro interno do servidor   |

---

### 2. Usuários (`/users`)

---

#### `GET /users/:id`

Retorna os dados de um usuário. Requer autenticação.

**Resposta de sucesso — `200 OK`:**

```json
{
  "id": "usr_abc123",
  "name": "João Silva",
  "email": "joao@email.com",
  "created_at": "2024-03-10T10:00:00.000Z"
}
```

**Respostas de erro:**

| Código | Situação                  |
| ------ | ------------------------- |
| 401    | Token ausente ou inválido |
| 404    | Usuário não encontrado    |
| 500    | Erro interno do servidor  |

---

#### `PATCH /users/:id`

Atualiza parcialmente os dados do usuário autenticado. Requer autenticação.

**Corpo da requisição (apenas campos a atualizar):**

```json
{
  "name": "João Atualizado",
  "email": "novo@email.com",
  "password": "NovaSenha123"
}
```

**Resposta de sucesso — `200 OK`:** (objeto completo do usuário atualizado)

**Respostas de erro:**

| Código | Situação                              |
| ------ | ------------------------------------- |
| 401    | Token ausente ou inválido             |
| 403    | Usuário não tem permissão para editar |
| 404    | Usuário não encontrado                |
| 409    | E-mail já em uso por outro usuário    |
| 500    | Erro interno do servidor              |

---

#### `DELETE /users/:id`

Remove a conta do usuário autenticado. Requer autenticação.

**Resposta de sucesso — `204 No Content`:** (sem corpo)

**Respostas de erro:**

| Código | Situação                               |
| ------ | -------------------------------------- |
| 401    | Token ausente ou inválido              |
| 403    | Usuário não tem permissão para deletar |
| 404    | Usuário não encontrado                 |
| 500    | Erro interno do servidor               |

---

### 3. Caches (`/caches`)

Representa os pontos de cache escondidos no mapa.

---

#### `GET /caches`

Lista todos os caches públicos. Suporta filtragem por proximidade geográfica. Requer autenticação.

**Query parameters opcionais:**

| Parâmetro | Tipo   | Descrição                        |
| --------- | ------ | -------------------------------- |
| `lat`     | double | Latitude do ponto de referência  |
| `lng`     | double | Longitude do ponto de referência |
| `raio_km` | double | Raio máximo em km (padrão: 10)   |

**Resposta de sucesso — `200 OK`:**

```json
[
  {
    "id": "cache_abc123",
    "title": "Pico do Jaraguá",
    "description": "Cache escondido próximo à trilha principal.",
    "latitude": -23.4561,
    "longitude": -46.7612,
    "difficulty_level": "medium",
    "qr_code_content": "GQ-cache_abc123-a1b2c3",
    "qr_code_image_url": "https://api.geoquest.app/qrcodes/cache_abc123.png",
    "creator_id": "usr_xyz",
    "created_at": "2024-03-10T10:00:00.000Z",
    "status": "active"
  }
]
```

**Valores válidos para `difficulty_level`:** `easy`, `medium`, `hard`, `extreme`  
**Valores válidos para `status`:** `active`, `inactive`, `pending`, `removed`

**Respostas de erro:**

| Código | Situação                  |
| ------ | ------------------------- |
| 401    | Token ausente ou inválido |
| 500    | Erro interno do servidor  |

---

#### `GET /caches/:id`

Retorna os detalhes de um cache específico. Requer autenticação.

**Resposta de sucesso — `200 OK`:** (mesmo objeto acima, singular)

**Respostas de erro:**

| Código | Situação                  |
| ------ | ------------------------- |
| 401    | Token ausente ou inválido |
| 404    | Cache não encontrado      |
| 500    | Erro interno do servidor  |

---

#### `POST /caches`

Cria um novo cache. Requer autenticação. O backend gera `id`, `qr_code_content`, `qr_code_image_url` e `created_at`.

**Corpo da requisição:**

```json
{
  "title": "Pico do Jaraguá",
  "description": "Cache escondido próximo à trilha principal.",
  "latitude": -23.4561,
  "longitude": -46.7612,
  "difficulty_level": "medium",
  "tip": "Procure perto das pedras grandes."
}
```

`tip` é opcional.

**Resposta de sucesso — `201 Created`:** (objeto completo do cache)

**Respostas de erro:**

| Código | Situação                                    |
| ------ | ------------------------------------------- |
| 400    | Campos obrigatórios ausentes                |
| 401    | Token ausente ou inválido                   |
| 422    | Latitude/longitude fora dos limites válidos |
| 500    | Erro interno do servidor                    |

---

#### `PATCH /caches/:id`

Atualiza parcialmente um cache. Apenas o criador pode editar. Requer autenticação.

**Corpo da requisição (apenas campos a atualizar):**

```json
{
  "title": "Novo título",
  "description": "Nova descrição",
  "status": "inactive"
}
```

**Resposta de sucesso — `200 OK`:** (objeto completo atualizado)

**Respostas de erro:**

| Código | Situação                         |
| ------ | -------------------------------- |
| 401    | Token ausente ou inválido        |
| 403    | Usuário não é o criador do cache |
| 404    | Cache não encontrado             |
| 500    | Erro interno do servidor         |

---

#### `DELETE /caches/:id`

Remove um cache. Apenas o criador pode deletar. Requer autenticação.

**Resposta de sucesso — `204 No Content`:** (sem corpo)

**Respostas de erro:**

| Código | Situação                         |
| ------ | -------------------------------- |
| 401    | Token ausente ou inválido        |
| 403    | Usuário não é o criador do cache |
| 404    | Cache não encontrado             |
| 500    | Erro interno do servidor         |

---

### 4. Avaliações (`/caches/:id/avaliacoes`)

---

#### `GET /caches/:id/avaliacoes`

Lista todas as avaliações de um cache. Requer autenticação.

**Resposta de sucesso — `200 OK`:**

```json
[
  {
    "id": "aval_001",
    "cache_id": "cache_abc123",
    "usuario_id": "usr_xyz",
    "nota": 5,
    "comentario": "Lugar incrível, vale a pena!",
    "criado_em": "2024-03-11T08:30:00.000Z"
  }
]
```

**Respostas de erro:**

| Código | Situação                  |
| ------ | ------------------------- |
| 401    | Token ausente ou inválido |
| 404    | Cache não encontrado      |
| 500    | Erro interno do servidor  |

---

#### `POST /caches/:id/avaliacoes`

Registra uma avaliação para um cache. Requer autenticação.

**Corpo da requisição:**

```json
{
  "nota": 5,
  "comentario": "Lugar incrível!"
}
```

**Resposta de sucesso — `201 Created`:** (objeto completo da avaliação)

**Respostas de erro:**

| Código | Situação                            |
| ------ | ----------------------------------- |
| 401    | Token ausente ou inválido           |
| 404    | Cache não encontrado                |
| 409    | Usuário já avaliou este cache       |
| 422    | Nota fora do intervalo válido (1–5) |
| 500    | Erro interno do servidor            |

---

### 5. Check-in (`/caches/:id/checkin`)

---

#### `POST /caches/:id/checkin`

Registra que o usuário encontrou o cache via leitura do QR Code. Requer autenticação.

**Corpo da requisição:**

```json
{
  "qr_code_content": "GQ-cache_abc123-a1b2c3"
}
```

**Resposta de sucesso — `200 OK`:**

```json
{
  "mensagem": "Check-in realizado com sucesso!",
  "cache_id": "cache_abc123",
  "usuario_id": "usr_xyz",
  "realizado_em": "2024-03-15T14:22:00.000Z"
}
```

**Respostas de erro:**

| Código | Situação                            |
| ------ | ----------------------------------- |
| 400    | `qr_code_content` ausente           |
| 401    | Token ausente ou inválido           |
| 404    | Cache não encontrado                |
| 409    | Usuário já fez check-in neste cache |
| 422    | QR Code inválido para este cache    |
| 500    | Erro interno do servidor            |

---

## Notas sobre cache local

- A lista de caches é armazenada localmente com `sqflite` após cada requisição.
- O TTL (tempo de vida) do cache local é de **15 minutos**.
- Se o dado local existir e for recente, a requisição à API é ignorada.
- Operações de escrita (POST, PATCH, DELETE) sempre vão para a API.
- Favoritos são armazenados **apenas localmente** — não há endpoint de favorito.
- Check-in é validado pela API; o dado local é atualizado após confirmação.
