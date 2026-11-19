import { z } from 'zod';

export const ResetPasswordDto = z.object({
  token: z.string().min(1),
  password: z.string().min(8),
});

export type ResetPasswordDtoType = z.infer<typeof ResetPasswordDto>;