import type { FastifyRequest, FastifyReply } from 'fastify';
import { usersService } from './users.service';
import { UpdateProfileDto } from './dto/update-profile.dto';
import { UpdateHealthDto } from './dto/update-health.dto';
import { UpdatePreferencesDto } from './dto/update-preferences.dto';

export const usersController = {

  getMe: async (req: FastifyRequest, reply: FastifyReply) => {
    try {
      const data = await usersService.getMe((req as any).userId);
      return reply.code(200).send({ success: true, data });
    } catch (e: any) {
      if (e.message === 'USER_NOT_FOUND')
        return reply.code(404).send({ success: false, message: 'Utilisateur introuvable' });
      return reply.code(500).send({ success: false, message: 'Erreur serveur' });
    }
  },

  updateProfile: async (req: FastifyRequest, reply: FastifyReply) => {
    try {
      const body = UpdateProfileDto.parse(req.body);
      const data = await usersService.updateProfile((req as any).userId, body);
      return reply.code(200).send({ success: true, data });
    } catch (e: any) {
      if (e.name === 'ZodError')
        return reply.code(400).send({ success: false, errors: e.errors });
      return reply.code(500).send({ success: false, message: 'Erreur serveur' });
    }
  },

  updateHealth: async (req: FastifyRequest, reply: FastifyReply) => {
    try {
      const body = UpdateHealthDto.parse(req.body);
      const data = await usersService.updateHealth((req as any).userId, body);
      return reply.code(200).send({ success: true, data });
    } catch (e: any) {
      if (e.name === 'ZodError')
        return reply.code(400).send({ success: false, errors: e.errors });
      return reply.code(500).send({ success: false, message: 'Erreur serveur' });
    }
  },

  updatePreferences: async (req: FastifyRequest, reply: FastifyReply) => {
    try {
      const body = UpdatePreferencesDto.parse(req.body);
      const data = await usersService.updatePreferences((req as any).userId, body);
      return reply.code(200).send({ success: true, data });
    } catch (e: any) {
      if (e.name === 'ZodError')
        return reply.code(400).send({ success: false, errors: e.errors });
      return reply.code(500).send({ success: false, message: 'Erreur serveur' });
    }
  },

  getPublicProfile: async (req: FastifyRequest<{ Params: { id: string } }>, reply: FastifyReply) => {
    try {
      const data = await usersService.getPublicProfile(req.params.id);
      return reply.code(200).send({ success: true, data });
    } catch (e: any) {
      if (e.message === 'USER_NOT_FOUND')
        return reply.code(404).send({ success: false, message: 'Utilisateur introuvable' });
      return reply.code(500).send({ success: false, message: 'Erreur serveur' });
    }
  },
};