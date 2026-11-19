import { prisma } from '../../lib/prisma';

export const authRepository = {
  findByEmail: (email: string) =>
    prisma.users.findFirst({ where: { email } }),

  findByUsername: (username: string) =>
    prisma.users.findFirst({ where: { username } }),

  findById: (userId: bigint) =>
    prisma.users.findFirst({ where: { user_id: userId } }),

  createUser: (data: {
    email: string;
    username: string;
    password_hash: string;
    phone?: string;
  }) =>
    prisma.users.create({
      data: { ...data, status: 'active', updated_at: new Date() },
    }),

  updateLastLogin: (userId: bigint) =>
    prisma.users.update({
      where: { user_id: userId },
      data: { last_login: new Date(), updated_at: new Date() },
    }),

  saveRefreshToken: (userId: bigint, token: string, expiresAt: Date) =>
    prisma.user_sessions.create({
      data: { session_id: token, user_id: userId, expires_at: expiresAt, is_active: true },
    }),

  findRefreshToken: (token: string) =>
    prisma.user_sessions.findFirst({
      where: { session_id: token, is_active: true },
    }),

  deleteRefreshToken: (token: string) =>
    prisma.user_sessions.updateMany({
      where: { session_id: token },
      data: { is_active: false },
    }),

  deleteAllRefreshTokens: (userId: bigint) =>
    prisma.user_sessions.updateMany({
      where: { user_id: userId },
      data: { is_active: false },
    }),

  saveResetToken: (userId: bigint, token: string, expiresAt: Date) =>
    prisma.user_sessions.create({
      data: {
        session_id: `reset_${token}`,
        user_id: userId,
        expires_at: expiresAt,
        is_active: true,
      },
    }),

  findResetToken: (token: string) =>
    prisma.user_sessions.findFirst({
      where: { session_id: `reset_${token}`, is_active: true },
    }),

  deleteResetToken: (token: string) =>
    prisma.user_sessions.updateMany({
      where: { session_id: `reset_${token}` },
      data: { is_active: false },
    }),

  updatePassword: (userId: bigint, password_hash: string) =>
    prisma.users.update({
      where: { user_id: userId },
      data: { password_hash, updated_at: new Date() },
    }),
};