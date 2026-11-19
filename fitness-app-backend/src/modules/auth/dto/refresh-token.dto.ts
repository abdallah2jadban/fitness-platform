import { z } from 'zod';

export const RefreshTokenDto = z.object({
  refreshToken: z.string().min(1),
});

export type RefreshTokenDtoType = z.infer<typeof RefreshTokenDto>;