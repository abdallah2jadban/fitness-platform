import 'dotenv/config';
import { buildApp } from './app';
import { prisma } from './lib/prisma';

const PORT = Number(process.env.PORT) || 3000;
const HOST = process.env.HOST || '0.0.0.0';

async function main() {
  const app = await buildApp();

  try {
    // Tester la connexion BD
    await prisma.$queryRaw`SELECT 1`;
    console.log('✅ Base de données connectée');

    // Démarrer le serveur
    await app.listen({ port: PORT, host: HOST });
    console.log(`🚀 Serveur démarré sur http://localhost:${PORT}`);
    console.log(`📋 Health check: http://localhost:${PORT}/health`);

  } catch (error) {
    console.error('❌ Erreur au démarrage:', error);
    await prisma.$disconnect();
    process.exit(1);
  }
}

// Graceful shutdown
process.on('SIGINT', async () => {
  console.log('\n🛑 Arrêt du serveur...');
  await prisma.$disconnect();
  process.exit(0);
});

main();