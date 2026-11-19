import path from 'node:path';
import { defineConfig } from 'prisma/config';
import 'dotenv/config';

const connectionString =
  process.env.DATABASE_URL ?? 'postgresql://postgres@localhost:5432/fitness_app';

export default defineConfig({
  schema: path.join('prisma', 'schema.prisma'),
  datasource: {
    url: connectionString,
  },
  migrations: {
    seed: 'ts-node ./prisma/seed.ts',
  },
});