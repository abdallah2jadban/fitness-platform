import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import crypto from 'crypto';
import { authRepository } from './auth.repository';
import type { RegisterDtoType } from './dto/register.dto';
import type { LoginDtoType } from './dto/login.dto';

const JWT_SECRET       = process.env.JWT_SECRET       ?? 'jwt_secret_change_me';
const REFRESH_SECRET   = process.env.REFRESH_SECRET   ?? 'refresh_secret_change_me';
const JWT_EXPIRES_IN   = process.env.JWT_EXPIRES_IN   ?? '15m';
const REFRESH_EXPIRES  = process.env.REFRESH_EXPIRES_IN ?? '7d';

export const authService = {

  // ─── Register ────────────────────────────────────────────
  register: async (data: RegisterDtoType) => {
    if (await authRepository.findByEmail(data.email))
      throw new Error('EMAIL_EXISTS');
    if (await authRepository.findByUsername(data.username))
      throw new Error('USERNAME_EXISTS');

    const password_hash = await bcrypt.hash(data.password, 12);
    const user = await authRepository.createUser({
      email: data.email,
      username: data.username,
      password_hash,
      phone: data.phone,
    });

    const tokens = authService.generateTokens(user.user_id.toString());
    await authService.saveRefresh(user.user_id, tokens.refreshToken);

    return {
      user: {
        id:       user.user_id.toString(),
        email:    user.email,
        username: user.username,
      },
      ...tokens,
    };
  },

  // ─── Login ───────────────────────────────────────────────
  login: async (data: LoginDtoType) => {
    const user = await authRepository.findByEmail(data.email);
    if (!user) throw new Error('INVALID_CREDENTIALS');

    const valid = await bcrypt.compare(data.password, user.password_hash);
    if (!valid) throw new Error('INVALID_CREDENTIALS');

    if (user.status === 'suspended' || user.status === 'deleted')
      throw new Error('ACCOUNT_DISABLED');

    await authRepository.updateLastLogin(user.user_id);
    const tokens = authService.generateTokens(user.user_id.toString());
    await authService.saveRefresh(user.user_id, tokens.refreshToken);

    return {
      user: {
        id:       user.user_id.toString(),
        email:    user.email,
        username: user.username,
        status:   user.status,
      },
      ...tokens,
    };
  },

  // ─── Logout ──────────────────────────────────────────────
  logout: async (refreshToken: string) => {
    await authRepository.deleteRefreshToken(refreshToken);
  },

  // ─── Refresh Token ───────────────────────────────────────
  refresh: async (refreshToken: string) => {
    const session = await authRepository.findRefreshToken(refreshToken);
    if (!session) throw new Error('INVALID_REFRESH_TOKEN');
    if (session.expires_at < new Date()) {
      await authRepository.deleteRefreshToken(refreshToken);
      throw new Error('REFRESH_TOKEN_EXPIRED');
    }

    const payload = jwt.verify(refreshToken, REFRESH_SECRET) as { userId: string };
    const accessToken = jwt.sign(
      { userId: payload.userId },
      JWT_SECRET,
      { expiresIn: JWT_EXPIRES_IN } as jwt.SignOptions
    );

    return { accessToken };
  },

  // ─── Forgot Password ─────────────────────────────────────
  forgotPassword: async (email: string) => {
    const user = await authRepository.findByEmail(email);
    // On retourne toujours success pour ne pas révéler si l'email existe
    if (!user) return { message: 'EMAIL_SENT' };

    const token = crypto.randomBytes(32).toString('hex');
    const expiresAt = new Date(Date.now() + 1 * 60 * 60 * 1000); // 1 heure

    await authRepository.saveResetToken(user.user_id, token, expiresAt);

    // TODO: envoyer l'email avec nodemailer
    // await emailService.sendResetPassword(user.email, token);
    console.log(`🔑 Reset token pour ${email}: ${token}`);

    return { message: 'EMAIL_SENT' };
  },

  // ─── Reset Password ──────────────────────────────────────
  resetPassword: async (token: string, newPassword: string) => {
    const session = await authRepository.findResetToken(token);
    if (!session) throw new Error('INVALID_RESET_TOKEN');
    if (session.expires_at < new Date()) {
      await authRepository.deleteResetToken(token);
      throw new Error('RESET_TOKEN_EXPIRED');
    }

    const password_hash = await bcrypt.hash(newPassword, 12);
    await authRepository.updatePassword(session.user_id, password_hash);
    await authRepository.deleteResetToken(token);
    await authRepository.deleteAllRefreshTokens(session.user_id);

    return { message: 'PASSWORD_RESET' };
  },

  // ─── Helpers ─────────────────────────────────────────────
  generateTokens: (userId: string) => ({
    accessToken: jwt.sign({ userId }, JWT_SECRET, {
      expiresIn: JWT_EXPIRES_IN,
    } as jwt.SignOptions),
    refreshToken: jwt.sign({ userId }, REFRESH_SECRET, {
      expiresIn: REFRESH_EXPIRES,
    } as jwt.SignOptions),
  }),

  saveRefresh: async (userId: bigint, token: string) => {
    const expiresAt = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000);
    await authRepository.saveRefreshToken(userId, token, expiresAt);
  },

  verifyAccessToken: (token: string) =>
    jwt.verify(token, JWT_SECRET) as { userId: string },
};