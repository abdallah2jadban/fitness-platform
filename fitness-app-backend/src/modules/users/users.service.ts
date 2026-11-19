import { usersRepository } from './users.repository';
import type { UpdateProfileDtoType } from './dto/update-profile.dto';
import type { UpdateHealthDtoType } from './dto/update-health.dto';
import type { UpdatePreferencesDtoType } from './dto/update-preferences.dto';

// Fix BigInt serialization
const convertBigInt = (obj: any): any => {
  if (obj === null || obj === undefined) return obj;
  if (typeof obj === 'bigint') return obj.toString();
  if (Array.isArray(obj)) return obj.map(convertBigInt);
  if (typeof obj === 'object') {
    return Object.fromEntries(
      Object.entries(obj).map(([k, v]) => [k, convertBigInt(v)])
    );
  }
  return obj;
};

export const usersService = {

  getMe: async (userId: string) => {
    const uid = BigInt(userId);
    const [user, profile, health, preferences] = await Promise.all([
      usersRepository.findById(uid),
      usersRepository.findProfile(uid),
      usersRepository.findHealth(uid),
      usersRepository.findPreferences(uid),
    ]);
    if (!user) throw new Error('USER_NOT_FOUND');
    return convertBigInt({ ...user, profile, health, preferences });
  },

  updateProfile: async (userId: string, data: UpdateProfileDtoType) => {
    const uid = BigInt(userId);
    const profile = await usersRepository.upsertProfile(uid, data);
    return convertBigInt(profile);
  },

  updateHealth: async (userId: string, data: UpdateHealthDtoType) => {
    const uid = BigInt(userId);
    const health = await usersRepository.upsertHealth(uid, data);
    return convertBigInt(health);
  },

  updatePreferences: async (userId: string, data: UpdatePreferencesDtoType) => {
    const uid = BigInt(userId);
    const prefs = await usersRepository.upsertPreferences(uid, data);
    return convertBigInt(prefs);
  },

  getPublicProfile: async (userId: string) => {
    const uid = BigInt(userId);
    const user = await usersRepository.findPublicProfile(uid);
    if (!user) throw new Error('USER_NOT_FOUND');
    return convertBigInt(user);
  },
};