// src/lib/prisma.ts
import { PrismaClient } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import 'dotenv/config';

const adapter = new PrismaPg({
  connectionString: process.env.DATABASE_URL ?? 'postgresql://postgres@localhost:5432/fitness_app'
});

export const prisma = new PrismaClient({ adapter });