import { z } from 'zod';

export const UpdateHealthDto = z.object({
  height:         z.number().positive().optional(),
  weight:         z.number().positive().optional(),
  blood_type:     z.enum(['A+','A-','B+','B-','AB+','AB-','O+','O-']).optional(),
  fitness_level:  z.enum(['beginner','intermediate','advanced','expert']).optional(),
  activity_level: z.enum(['sedentary','lightly_active','moderately_active','very_active','extremely_active']).optional(),
});

export type UpdateHealthDtoType = z.infer<typeof UpdateHealthDto>;