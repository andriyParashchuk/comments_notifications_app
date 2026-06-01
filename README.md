## Setup

### 1. Install dependencies

```bash
bundle install
```

### 2. Run Meilisearch

```bash
docker compose up -d
```

### 3. Initialize Database

```bash
bin/rails db:prepare
```

### 4. Start the Application

```bash
bin/dev
```

or

```bash
bin/rails s
```
