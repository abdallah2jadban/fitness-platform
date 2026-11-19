import { z } from 'zod';

export const RegisterDto = z.object({
  email: z.string().email('Email invalide'),
  username: z.string().min(3).max(50),
  password: z.string().min(8, 'Min 8 caractères'),
  phone: z.string().optional(),
});

export type RegisterDtoType = z.infer<typeof RegisterDto>;