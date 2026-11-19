require('dotenv').config(); // charge le .env
const { prisma } = require('./prisma/prisma.config.ts'); // <-- nouveau PrismaClient

async function testConnection() {
  try {
    console.log('Testing database connection...');
    await prisma.$connect();
    console.log('✅ Connected to database');

    const count = await prisma.user.count();
    console.log(`Found ${count} users in database`);

    if (count > 0) {
      const users = await prisma.user.findMany({ take: 3 });
      console.log('Sample users:', users);
    }

  } catch (error) {
    console.error('❌ Database error:', error);
  } finally {
    await prisma.$disconnect();
    console.log('Disconnected from database');
  }
}

testConnection();