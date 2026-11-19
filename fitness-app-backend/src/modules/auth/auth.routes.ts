import type { FastifyInstance } from 'fastify';
import { authController } from './auth.controller';

export const authRoutes = async (app: FastifyInstance) => {
  app.post('/register',         authController.register);
  app.post('/login',            authController.login);
  app.post('/logout',           authController.logout);
  app.post('/refresh',          authController.refresh);
  app.post('/forgot-password',  authController.forgotPassword);
  app.post('/reset-password',   authController.resetPassword);
};