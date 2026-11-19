import { prisma } from '../../lib/prisma';

export const usersRepository = {

  findById: (userId: bigint) =>
    prisma.users.findFirst({
      where: { user_id: userId },
      select: {
        user_id: true, email: true, username: true,
        phone: true, status: true, email_verified: true,
        created_at: true, last_login: true, profile_completed: true,
      },
    }),

  findProfile: (userId: bigint) =>
    prisma.user_profiles.findFirst({ where: { user_id: userId } }),

  findHealth: (userId: bigint) =>
    prisma.health_profiles.findFirst({ where: { user_id: userId } }),

  findPreferences: (userId: bigint) =>
    prisma.user_preferences.findFirst({ where: { user_id: userId } }),

  updateUser: (userId: bigint, data: { phone?: string; username?: string }) =>
    prisma.users.update({
      where: { user_id: userId },
      data: { ...data, updated_at: new Date() },
    }),

  upsertProfile: (userId: bigint, data: any) =>
    prisma.user_profiles.upsert({
      where: { user_id: userId },
      update: { ...data, updated_at: new Date() },
      create: { user_id: userId, ...data, updated_at: new Date() },
    }),

  upsertHealth: (userId: bigint, data: any) =>
    prisma.health_profiles.upsert({
      where: { user_id: userId },
      update: { ...data, updated_at: new Date() },
      create: { user_id: userId, ...data, updated_at: new Date() },
    }),

  upsertPreferences: (userId: bigint, data: any) =>
    prisma.user_preferences.upsert({
      where: { user_id: userId },
      update: { ...data, updated_at: new Date() },
      create: { user_id: userId, ...data, updated_at: new Date() },
    }),

  findPublicProfile: (userId: bigint) =>
    prisma.users.findFirst({
      where: { user_id: userId, status: 'active' },
      select: {
        user_id: true, username: true,
        user_profiles: {
          select: {
            first_name: true, last_name: true,
            bio: true, city: true, country: true,
            profile_picture_url: true,
          },
        },
      },
    }),
};