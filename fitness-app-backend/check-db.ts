// check-db.ts
import { PrismaClient } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import 'dotenv/config';

const adapter = new PrismaPg({
  connectionString: process.env.DATABASE_URL ?? 'postgresql://postgres@localhost:5432/fitness_app'
});
const prisma = new PrismaClient({ adapter });

async function checkDatabase() {
  console.log('🔍 Vérification complète de la base de données...\n');

  try {
    const tables = [
      { name: '👤 users',                        count: await prisma.users.count() },
      { name: '📋 user_profiles',                count: await prisma.user_profiles.count() },
      { name: '💊 health_profiles',              count: await prisma.health_profiles.count() },
      { name: '⚙️  user_preferences',            count: await prisma.user_preferences.count() },
      { name: '📊 user_metrics',                 count: await prisma.user_metrics.count() },
      { name: '🔐 user_sessions',                count: await prisma.user_sessions.count() },
      { name: '🏋️  exercises',                   count: await prisma.exercises.count() },
      { name: '🎯 goals',                        count: await prisma.goals.count() },
      { name: '📅 training_plans',               count: await prisma.training_plans.count() },
      { name: '💪 workout_sessions',             count: await prisma.workout_sessions.count() },
      { name: '🔄 session_exercises',            count: await prisma.session_exercises.count() },
      { name: '🤖 ai_recommendations',           count: await prisma.ai_recommendations.count() },
      { name: '🏆 achievements',                 count: await prisma.achievements.count() },
      { name: '🥇 user_achievements',            count: await prisma.user_achievements.count() },
      { name: '📣 events',                       count: await prisma.events.count() },
      { name: '👥 event_participants',           count: await prisma.event_participants.count() },
      { name: '💬 conversations',                count: await prisma.conversations.count() },
      { name: '👤 conversation_participants',    count: await prisma.conversation_participants.count() },
      { name: '📨 messages',                     count: await prisma.messages.count() },
      { name: '📖 stories',                      count: await prisma.stories.count() },
      { name: '👁️  story_views',                 count: await prisma.story_views.count() },
      { name: '🤝 friendships',                  count: await prisma.friendships.count() },
      { name: '🏢 collaborator_types',           count: await prisma.collaborator_types.count() },
      { name: '🏢 collaborators',                count: await prisma.collaborators.count() },
      { name: '⭐ collaborator_reviews',         count: await prisma.collaborator_reviews.count() },
      { name: '❤️  user_favorite_collaborators', count: await prisma.user_favorite_collaborators.count() },
      { name: '🗺️  routes',                      count: await prisma.routes.count() },
      { name: '🔗 route_shares',                 count: await prisma.route_shares.count() },
      { name: '🏃 route_activities',             count: await prisma.route_activities.count() },
      { name: '📆 custom_schedules',             count: await prisma.custom_schedules.count() },
      { name: '🗒️  schedule_items',              count: await prisma.schedule_items.count() },
      { name: '🔔 notifications',                count: await prisma.notifications.count() },
    ];

    console.log('📊 ÉTAT DES 33 TABLES :');
    console.log('═'.repeat(50));

    let tablesWithData = 0;
    let emptyTables = 0;

    for (const table of tables) {
      const status = table.count > 0 ? '✅' : '⚪';
      if (table.count > 0) tablesWithData++;
      else emptyTables++;
      console.log(`${status} ${table.name.padEnd(35)} ${table.count} enregistrement(s)`);
    }

    console.log('═'.repeat(50));
    console.log(`\n📈 RÉSUMÉ :`);
    console.log(`✅ Tables avec données : ${tablesWithData}`);
    console.log(`⚪ Tables vides        : ${emptyTables}`);
    console.log(`📦 Total tables        : ${tables.length}`);

    // Vérifier les données seedées
    console.log('\n🔎 DONNÉES SEEDÉES :');
    console.log('─'.repeat(50));

    const user = await prisma.users.findFirst({ where: { email: 'test@example.com' } });
    console.log(user ? `✅ Utilisateur test    : ${user.email}` : '❌ Aucun utilisateur test trouvé');

    const collabTypes = await prisma.collaborator_types.findMany({ select: { type_name: true } });
    console.log(`✅ Collab. types       : ${collabTypes.map(c => c.type_name).join(', ')}`);

    const exercises = await prisma.exercises.findMany({ select: { exercise_name: true } });
    console.log(`✅ Exercices           : ${exercises.map(e => e.exercise_name).join(', ')}`);

    console.log('\n🎉 Base de données complète et bien connectée avec Prisma !');

  } catch (error) {
    console.error('❌ Erreur de connexion:', error);
  } finally {
    await prisma.$disconnect();
  }
}

checkDatabase();