import { PrismaClient } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import 'dotenv/config';

const adapter = new PrismaPg({ 
  connectionString: process.env.DATABASE_URL ?? 'postgresql://postgres@localhost:5432/fitness_app'
});

const prisma = new PrismaClient({ adapter });

async function testConnection() {
  try {
    console.log('🔌 Testing database connection...');

    const counts = {
      users: await prisma.users.count(),
      exercises: await prisma.exercises.count(),
      goals: await prisma.goals.count(),
      events: await prisma.events.count(),
      collaboratorTypes: await prisma.collaborator_types.count(),
    };

    console.log('✅ Connection successful!');
    console.log('📊 Table counts:', counts);

  } catch (error) {
    console.error('❌ Connection failed:', error);
  } finally {
    await prisma.$disconnect();
  }
}

testConnection();