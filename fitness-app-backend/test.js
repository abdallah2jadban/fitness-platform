const { PrismaClient } = require('@prisma/client')

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: process.env.DATABASE_URL || 'postgresql://postgres@localhost:5432/fitness_app'
    }
  }
})

async function main() {
  try {
    const users = await prisma.user.findMany()
    console.log('Users found:', users.length)
    console.log(users)
  } catch (error) {
    console.error('Error connecting to database:', error)
  }
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect())
