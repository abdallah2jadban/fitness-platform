import Fastify from 'fastify';
import cors from '@fastify/cors';
import helmet from '@fastify/helmet';
import rateLimit from '@fastify/rate-limit';
import { prisma } from './lib/prisma';
import { authRoutes } from './modules/auth/auth.routes';
import { usersRoutes } from './modules/users/users.routes';

export const buildApp = async () => {
  const app = Fastify({
    logger: {
      transport: { target: 'pino-pretty', options: { colorize: true } },
    },
  });

  await app.register(cors, { origin: true });
  await app.register(helmet);
  await app.register(rateLimit, { max: 100, timeWindow: '1 minute' });

  // ─── Routes ────────────────────────────────────
  await app.register(authRoutes,  { prefix: '/api/auth' });
  await app.register(usersRoutes, { prefix: '/api/users' });

  // ─── Health ────────────────────────────────────
  app.get('/health', async () => {
    try {
      await prisma.$queryRaw`SELECT 1`;
      return { status: 'ok', database: 'connected', timestamp: new Date().toISOString() };
    } catch {
      return { status: 'error', database: 'disconnected' };
    }
  });

  app.get('/', async () => ({ message: '🏋️ Fitness App API', version: '1.0.0' }));

  return app;
};