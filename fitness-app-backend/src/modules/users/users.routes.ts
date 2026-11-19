import type { FastifyInstance } from 'fastify';
import { usersController } from './users.controller';
import { authenticate } from '../../shared/middlewares/auth.middleware';

export const usersRoutes = async (app: FastifyInstance) => {
  // Toutes les routes protégées
  app.get('/me',              { preHandler: authenticate }, usersController.getMe);
  app.put('/me/profile',      { preHandler: authenticate }, usersController.updateProfile);
  app.put('/me/health',       { preHandler: authenticate }, usersController.updateHealth);
  app.put('/me/preferences',  { preHandler: authenticate }, usersController.updatePreferences);

  // Route publique
  app.get('/:id',             usersController.getPublicProfile);
};