// prisma/seed.ts
import { PrismaClient, ExerciseCategory } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import bcrypt from 'bcryptjs';
import 'dotenv/config';

const adapter = new PrismaPg({
  connectionString: process.env.DATABASE_URL ?? 'postgresql://postgres@localhost:5432/fitness_app'
});

const prisma = new PrismaClient({ adapter });

async function main() {
  console.log('🌱 Début du seeding...');

  const hashedPassword = await bcrypt.hash('password123', 10);

  // Créer un utilisateur de test
  const user = await prisma.users.upsert({
    where: { email: 'test@example.com' },
    update: {},
    create: {
      email: 'test@example.com',
      username: 'testuser',
      password_hash: hashedPassword,
      status: 'active',
      email_verified: true,
      updated_at: new Date(),
    },
  });
  console.log('✅ Utilisateur créé:', user.email);

const collaboratorTypes = [
    { type_name: 'trainer', type_slug: 'trainer' },
    { type_name: 'nutritionist', type_slug: 'nutritionist' },
    { type_name: 'physiotherapist', type_slug: 'physiotherapist' },
  ];

  for (const type of collaboratorTypes) {
    await prisma.collaborator_types.upsert({
      where: { type_name: type.type_name },
      update: {},
      create: {
        type_name: type.type_name,
        type_slug: type.type_slug,
      },
    });
  }
  console.log('✅ Types de collaborateurs créés');

  // Créer des exercices (avec enum ExerciseCategory)
const exercises = [
    { exercise_name: 'Push Up', category: ExerciseCategory.strength, muscle_groups: ['chest'] },
    { exercise_name: 'Squat', category: ExerciseCategory.strength, muscle_groups: ['legs'] },
    { exercise_name: 'Running', category: ExerciseCategory.cardio, muscle_groups: ['full_body'] },
  ];

  for (const exercise of exercises) {
    await prisma.exercises.create({
      data: {
        exercise_name: exercise.exercise_name,
        category: exercise.category,
        muscle_groups: exercise.muscle_groups,
        updated_at: new Date(),
      },
    });
  }
  console.log('✅ Exercices créés');

  console.log('🎉 Seeding terminé !');
}

main()
  .catch((e) => {
    console.error('❌ Erreur:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });