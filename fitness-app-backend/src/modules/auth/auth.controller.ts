import type { FastifyRequest, FastifyReply } from 'fastify';
import { authService } from './auth.service';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import { RefreshTokenDto } from './dto/refresh-token.dto';
import { ForgotPasswordDto } from './dto/forgot-password.dto';
import { ResetPasswordDto } from './dto/reset-password.dto';

const handleError = (error: any, reply: FastifyReply) => {
  const map: Record<string, [number, string]> = {
    EMAIL_EXISTS:          [409, 'Email déjà utilisé'],
    USERNAME_EXISTS:       [409, 'Username déjà utilisé'],
    INVALID_CREDENTIALS:   [401, 'Email ou mot de passe incorrect'],
    ACCOUNT_DISABLED:      [403, 'Compte désactivé ou supprimé'],
    INVALID_REFRESH_TOKEN: [401, 'Token invalide'],
    REFRESH_TOKEN_EXPIRED: [401, 'Token expiré, reconnectez-vous'],
    INVALID_RESET_TOKEN:   [400, 'Lien invalide'],
    RESET_TOKEN_EXPIRED:   [400, 'Lien expiré, refaites la demande'],
  };
  const [code, message] = map[error.message] ?? [500, 'Erreur serveur'];
  return reply.code(code).send({ success: false, message });
};

export const authController = {

  register: async (req: FastifyRequest, reply: FastifyReply) => {
    try {
      const body = RegisterDto.parse(req.body);
      const data = await authService.register(body);
      return reply.code(201).send({ success: true, data });
    } catch (e: any) {
      if (e.name === 'ZodError')
        return reply.code(400).send({ success: false, errors: e.errors });
      return handleError(e, reply);
    }
  },

  login: async (req: FastifyRequest, reply: FastifyReply) => {
    try {
      const body = LoginDto.parse(req.body);
      const data = await authService.login(body);
      return reply.code(200).send({ success: true, data });
    } catch (e: any) {
      if (e.name === 'ZodError')
        return reply.code(400).send({ success: false, errors: e.errors });
      return handleError(e, reply);
    }
  },

  logout: async (req: FastifyRequest, reply: FastifyReply) => {
    try {
      const body = RefreshTokenDto.parse(req.body);
      await authService.logout(body.refreshToken);
      return reply.code(200).send({ success: true, message: 'Déconnecté avec succès' });
    } catch (e: any) {
      return handleError(e, reply);
    }
  },

  refresh: async (req: FastifyRequest, reply: FastifyReply) => {
    try {
      const body = RefreshTokenDto.parse(req.body);
      const data = await authService.refresh(body.refreshToken);
      return reply.code(200).send({ success: true, data });
    } catch (e: any) {
      return handleError(e, reply);
    }
  },

  forgotPassword: async (req: FastifyRequest, reply: FastifyReply) => {
    try {
      const body = ForgotPasswordDto.parse(req.body);
      const data = await authService.forgotPassword(body.email);
      return reply.code(200).send({ success: true, data });
    } catch (e: any) {
      if (e.name === 'ZodError')
        return reply.code(400).send({ success: false, errors: e.errors });
      return handleError(e, reply);
    }
  },

  resetPassword: async (req: FastifyRequest, reply: FastifyReply) => {
    try {
      const body = ResetPasswordDto.parse(req.body);
      const data = await authService.resetPassword(body.token, body.password);
      return reply.code(200).send({ success: true, data });
    } catch (e: any) {
      if (e.name === 'ZodError')
        return reply.code(400).send({ success: false, errors: e.errors });
      return handleError(e, reply);
    }
  },
};