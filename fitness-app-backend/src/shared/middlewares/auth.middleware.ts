import type { FastifyRequest, FastifyReply } from 'fastify';
import { authService } from '../../modules/auth/auth.service';

export const authenticate = async (req: FastifyRequest, reply: FastifyReply) => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return reply.code(401).send({
        success: false,
        message: 'Token manquant — connectez-vous',
      });
    }

    const token = authHeader.split(' ')[1];
    const payload = authService.verifyAccessToken(token);
    
    // Fix: cast as any
    (req as any).userId = payload.userId;

  } catch (error: any) {
    if (error.name === 'TokenExpiredError') {
      return reply.code(401).send({
        success: false,
        message: 'Token expiré — rafraîchissez votre token',
      });
    }
    return reply.code(401).send({
      success: false,
      message: 'Token invalide',
    });
  }
};