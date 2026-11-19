import { z } from 'zod';

export const UpdatePreferencesDto = z.object({
  preferred_workout_time:       z.enum(['morning','afternoon','evening','night']).optional(),
  preferred_workout_duration:   z.number().int().positive().optional(),
  workout_frequency_per_week:   z.number().int().min(1).max(7).optional(),
  language:                     z.string().max(10).optional(),
  timezone:                     z.string().optional(),
  unit_system:                  z.enum(['metric','imperial']).optional(),
  notification_enabled:         z.boolean().optional(),
  vr_preference:                z.boolean().optional(),
});

export type UpdatePreferencesDtoType = z.infer<typeof UpdatePreferencesDto>;