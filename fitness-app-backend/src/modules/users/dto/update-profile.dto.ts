import { z } from 'zod';

export const UpdateProfileDto = z.object({
  first_name:          z.string().max(100).optional(),
  last_name:           z.string().max(100).optional(),
  date_of_birth:       z.string().optional(),
  gender:              z.enum(['male','female','other','prefer_not_to_say']).optional(),
  bio:                 z.string().optional(),
  city:                z.string().max(100).optional(),
  country:             z.string().max(100).optional(),
  profile_picture_url: z.string().url().optional(),
});

export type UpdateProfileDtoType = z.infer<typeof UpdateProfileDto>;