#!/bin/bash

# =============================================
# Script de crÃ©ation de la structure Backend
# Fitness App - Enterprise Grade
# =============================================

set -e

PROJECT_NAME="fitness-app-backend"

echo "íº€ CrÃ©ation du projet: $PROJECT_NAME"
echo "============================================="

mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# =============================================
# .github
# =============================================
mkdir -p .github/workflows
touch .github/workflows/ci.yml
touch .github/workflows/cd-staging.yml
touch .github/workflows/cd-production.yml
touch .github/PULL_REQUEST_TEMPLATE.md
touch .github/CODEOWNERS

# =============================================
# .husky
# =============================================
mkdir -p .husky
touch .husky/pre-commit
touch .husky/commit-msg

# =============================================
# docker
# =============================================
mkdir -p docker/nginx
touch docker/Dockerfile
touch docker/Dockerfile.dev
touch docker/docker-compose.yml
touch docker/docker-compose.test.yml
touch docker/nginx/nginx.conf

# =============================================
# k8s
# =============================================
mkdir -p k8s/base
mkdir -p k8s/overlays/staging
mkdir -p k8s/overlays/production
mkdir -p k8s/secrets
touch k8s/base/deployment.yaml
touch k8s/base/service.yaml
touch k8s/base/configmap.yaml
touch k8s/base/ingress.yaml
touch k8s/secrets/sealed-secrets.yaml

# =============================================
# prisma
# =============================================
mkdir -p prisma/migrations/20240101_initial
mkdir -p prisma/migrations/20240215_add_vr_support
mkdir -p prisma/seeds
touch prisma/schema.prisma
touch prisma/seeds/index.ts
touch prisma/seeds/users.seed.ts
touch prisma/seeds/exercises.seed.ts
touch prisma/seeds/collaborators.seed.ts
touch prisma/seeds/achievements.seed.ts

# =============================================
# src/config
# =============================================
mkdir -p src/config
touch src/config/index.ts
touch src/config/app.config.ts
touch src/config/database.config.ts
touch src/config/redis.config.ts
touch src/config/jwt.config.ts
touch src/config/aws.config.ts
touch src/config/openai.config.ts
touch src/config/email.config.ts
touch src/config/swagger.config.ts

# =============================================
# src/core
# =============================================
mkdir -p src/core/entities
touch src/core/entities/user.entity.ts
touch src/core/entities/goal.entity.ts
touch src/core/entities/workout.entity.ts
touch src/core/entities/event.entity.ts
touch src/core/entities/message.entity.ts
touch src/core/entities/collaborator.entity.ts
touch src/core/entities/route.entity.ts
touch src/core/entities/achievement.entity.ts

mkdir -p src/core/value-objects
touch src/core/value-objects/email.vo.ts
touch src/core/value-objects/password.vo.ts
touch src/core/value-objects/coordinates.vo.ts
touch src/core/value-objects/duration.vo.ts
touch src/core/value-objects/rating.vo.ts

mkdir -p src/core/errors
touch src/core/errors/base.error.ts
touch src/core/errors/not-found.error.ts
touch src/core/errors/unauthorized.error.ts
touch src/core/errors/validation.error.ts
touch src/core/errors/conflict.error.ts
touch src/core/errors/business.error.ts

mkdir -p src/core/interfaces/repositories
touch src/core/interfaces/repositories/user.repository.ts
touch src/core/interfaces/repositories/goal.repository.ts
touch src/core/interfaces/repositories/workout.repository.ts
touch src/core/interfaces/repositories/event.repository.ts
touch src/core/interfaces/repositories/message.repository.ts
touch src/core/interfaces/repositories/collaborator.repository.ts

mkdir -p src/core/interfaces/services
touch src/core/interfaces/services/storage.service.ts
touch src/core/interfaces/services/email.service.ts
touch src/core/interfaces/services/ai.service.ts
touch src/core/interfaces/services/notification.service.ts

# =============================================
# src/modules/auth
# =============================================
mkdir -p src/modules/auth/strategies
mkdir -p src/modules/auth/dto
touch src/modules/auth/auth.module.ts
touch src/modules/auth/auth.controller.ts
touch src/modules/auth/auth.service.ts
touch src/modules/auth/auth.repository.ts
touch src/modules/auth/auth.test.ts
touch src/modules/auth/strategies/jwt.strategy.ts
touch src/modules/auth/strategies/google.strategy.ts
touch src/modules/auth/strategies/apple.strategy.ts
touch src/modules/auth/dto/register.dto.ts
touch src/modules/auth/dto/login.dto.ts
touch src/modules/auth/dto/refresh-token.dto.ts

# =============================================
# src/modules/users
# =============================================
mkdir -p src/modules/users/dto
touch src/modules/users/users.module.ts
touch src/modules/users/users.controller.ts
touch src/modules/users/users.service.ts
touch src/modules/users/users.repository.ts
touch src/modules/users/users.test.ts
touch src/modules/users/users.integration.test.ts
touch src/modules/users/dto/update-profile.dto.ts
touch src/modules/users/dto/update-health.dto.ts
touch src/modules/users/dto/update-preferences.dto.ts

# =============================================
# src/modules/workouts
# =============================================
mkdir -p src/modules/workouts/sessions
mkdir -p src/modules/workouts/exercises
mkdir -p src/modules/workouts/dto
touch src/modules/workouts/workouts.module.ts
touch src/modules/workouts/workouts.controller.ts
touch src/modules/workouts/workouts.service.ts
touch src/modules/workouts/workouts.repository.ts
touch src/modules/workouts/sessions/sessions.controller.ts
touch src/modules/workouts/sessions/sessions.service.ts
touch src/modules/workouts/sessions/sessions.repository.ts
touch src/modules/workouts/exercises/exercises.controller.ts
touch src/modules/workouts/exercises/exercises.service.ts
touch src/modules/workouts/exercises/exercises.repository.ts
touch src/modules/workouts/dto/create-plan.dto.ts
touch src/modules/workouts/dto/start-session.dto.ts
touch src/modules/workouts/dto/log-exercise.dto.ts

# =============================================
# src/modules/goals
# =============================================
mkdir -p src/modules/goals/dto
touch src/modules/goals/goals.module.ts
touch src/modules/goals/goals.controller.ts
touch src/modules/goals/goals.service.ts
touch src/modules/goals/goals.repository.ts
touch src/modules/goals/dto/create-goal.dto.ts
touch src/modules/goals/dto/update-goal.dto.ts

# =============================================
# src/modules/ai
# =============================================
mkdir -p src/modules/ai/providers
mkdir -p src/modules/ai/prompts
mkdir -p src/modules/ai/dto
touch src/modules/ai/ai.module.ts
touch src/modules/ai/ai.controller.ts
touch src/modules/ai/ai.service.ts
touch src/modules/ai/ai.repository.ts
touch src/modules/ai/providers/openai.provider.ts
touch src/modules/ai/providers/langchain.provider.ts
touch src/modules/ai/prompts/workout-plan.prompt.ts
touch src/modules/ai/prompts/nutrition.prompt.ts
touch src/modules/ai/prompts/coach.prompt.ts
touch src/modules/ai/dto/generate-plan.dto.ts

# =============================================
# src/modules/events
# =============================================
mkdir -p src/modules/events/participants
mkdir -p src/modules/events/dto
touch src/modules/events/events.module.ts
touch src/modules/events/events.controller.ts
touch src/modules/events/events.service.ts
touch src/modules/events/events.repository.ts
touch src/modules/events/participants/participants.service.ts
touch src/modules/events/participants/participants.repository.ts
touch src/modules/events/dto/create-event.dto.ts
touch src/modules/events/dto/register-event.dto.ts

# =============================================
# src/modules/chat
# =============================================
mkdir -p src/modules/chat/stories
mkdir -p src/modules/chat/dto
touch src/modules/chat/chat.module.ts
touch src/modules/chat/chat.controller.ts
touch src/modules/chat/chat.gateway.ts
touch src/modules/chat/chat.service.ts
touch src/modules/chat/chat.repository.ts
touch src/modules/chat/stories/stories.controller.ts
touch src/modules/chat/stories/stories.service.ts
touch src/modules/chat/stories/stories.repository.ts
touch src/modules/chat/dto/send-message.dto.ts
touch src/modules/chat/dto/create-story.dto.ts

# =============================================
# src/modules/social
# =============================================
mkdir -p src/modules/social/dto
touch src/modules/social/social.module.ts
touch src/modules/social/social.controller.ts
touch src/modules/social/social.service.ts
touch src/modules/social/social.repository.ts
touch src/modules/social/dto/friend-request.dto.ts

# =============================================
# src/modules/collaborators
# =============================================
mkdir -p src/modules/collaborators/reviews
mkdir -p src/modules/collaborators/dto
touch src/modules/collaborators/collaborators.module.ts
touch src/modules/collaborators/collaborators.controller.ts
touch src/modules/collaborators/collaborators.service.ts
touch src/modules/collaborators/collaborators.repository.ts
touch src/modules/collaborators/reviews/reviews.controller.ts
touch src/modules/collaborators/reviews/reviews.service.ts
touch src/modules/collaborators/reviews/reviews.repository.ts
touch src/modules/collaborators/dto/create-collaborator.dto.ts
touch src/modules/collaborators/dto/create-review.dto.ts

# =============================================
# src/modules/routes (GPS)
# =============================================
mkdir -p src/modules/routes/dto
touch src/modules/routes/routes.module.ts
touch src/modules/routes/routes.controller.ts
touch src/modules/routes/routes.service.ts
touch src/modules/routes/routes.repository.ts
touch src/modules/routes/dto/create-route.dto.ts
touch src/modules/routes/dto/log-activity.dto.ts

# =============================================
# src/modules/schedules
# =============================================
mkdir -p src/modules/schedules/dto
touch src/modules/schedules/schedules.module.ts
touch src/modules/schedules/schedules.controller.ts
touch src/modules/schedules/schedules.service.ts
touch src/modules/schedules/schedules.repository.ts
touch src/modules/schedules/dto/create-schedule.dto.ts

# =============================================
# src/modules/metrics
# =============================================
mkdir -p src/modules/metrics/dto
touch src/modules/metrics/metrics.module.ts
touch src/modules/metrics/metrics.controller.ts
touch src/modules/metrics/metrics.service.ts
touch src/modules/metrics/metrics.repository.ts
touch src/modules/metrics/dto/log-metrics.dto.ts

# =============================================
# src/modules/notifications
# =============================================
mkdir -p src/modules/notifications
touch src/modules/notifications/notifications.module.ts
touch src/modules/notifications/notifications.controller.ts
touch src/modules/notifications/notifications.service.ts
touch src/modules/notifications/notifications.repository.ts
touch src/modules/notifications/notifications.gateway.ts

# =============================================
# src/modules/achievements
# =============================================
mkdir -p src/modules/achievements/engine
touch src/modules/achievements/achievements.module.ts
touch src/modules/achievements/achievements.controller.ts
touch src/modules/achievements/achievements.service.ts
touch src/modules/achievements/achievements.repository.ts
touch src/modules/achievements/engine/achievement.engine.ts
touch src/modules/achievements/engine/achievement.rules.ts

# =============================================
# src/infrastructure/database
# =============================================
mkdir -p src/infrastructure/database/repositories
touch src/infrastructure/database/prisma.client.ts
touch src/infrastructure/database/knex.client.ts
touch src/infrastructure/database/repositories/base.repository.ts
touch src/infrastructure/database/repositories/user.repository.impl.ts

# =============================================
# src/infrastructure/cache
# =============================================
mkdir -p src/infrastructure/cache
touch src/infrastructure/cache/redis.client.ts
touch src/infrastructure/cache/cache.service.ts
touch src/infrastructure/cache/cache.keys.ts

# =============================================
# src/infrastructure/queue
# =============================================
mkdir -p src/infrastructure/queue/workers
mkdir -p src/infrastructure/queue/jobs
touch src/infrastructure/queue/queue.client.ts
touch src/infrastructure/queue/workers/email.worker.ts
touch src/infrastructure/queue/workers/ai-recommendation.worker.ts
touch src/infrastructure/queue/workers/push-notification.worker.ts
touch src/infrastructure/queue/workers/achievement.worker.ts
touch src/infrastructure/queue/workers/story-cleanup.worker.ts
touch src/infrastructure/queue/jobs/send-email.job.ts
touch src/infrastructure/queue/jobs/generate-ai-plan.job.ts
touch src/infrastructure/queue/jobs/expire-stories.job.ts

# =============================================
# src/infrastructure/storage
# =============================================
mkdir -p src/infrastructure/storage
touch src/infrastructure/storage/s3.client.ts
touch src/infrastructure/storage/storage.service.impl.ts
touch src/infrastructure/storage/upload.helper.ts

# =============================================
# src/infrastructure/email
# =============================================
mkdir -p src/infrastructure/email/templates
touch src/infrastructure/email/email.service.impl.ts
touch src/infrastructure/email/templates/welcome.html
touch src/infrastructure/email/templates/verify-email.html
touch src/infrastructure/email/templates/reset-password.html
touch src/infrastructure/email/templates/workout-reminder.html

# =============================================
# src/infrastructure/search
# =============================================
mkdir -p src/infrastructure/search/indices
touch src/infrastructure/search/elasticsearch.client.ts
touch src/infrastructure/search/search.service.ts
touch src/infrastructure/search/indices/collaborators.index.ts
touch src/infrastructure/search/indices/events.index.ts
touch src/infrastructure/search/indices/routes.index.ts

# =============================================
# src/infrastructure/push
# =============================================
mkdir -p src/infrastructure/push
touch src/infrastructure/push/firebase.client.ts
touch src/infrastructure/push/push.service.impl.ts

# =============================================
# src/shared
# =============================================
mkdir -p src/shared/decorators
touch src/shared/decorators/auth.decorator.ts
touch src/shared/decorators/roles.decorator.ts
touch src/shared/decorators/cache.decorator.ts

mkdir -p src/shared/guards
touch src/shared/guards/jwt-auth.guard.ts
touch src/shared/guards/roles.guard.ts
touch src/shared/guards/throttle.guard.ts

mkdir -p src/shared/middlewares
touch src/shared/middlewares/request-logger.middleware.ts
touch src/shared/middlewares/correlation-id.middleware.ts
touch src/shared/middlewares/ip-filter.middleware.ts

mkdir -p src/shared/interceptors
touch src/shared/interceptors/response-transform.interceptor.ts
touch src/shared/interceptors/cache.interceptor.ts
touch src/shared/interceptors/audit-log.interceptor.ts

mkdir -p src/shared/pipes
touch src/shared/pipes/validation.pipe.ts
touch src/shared/pipes/pagination.pipe.ts
touch src/shared/pipes/sanitize.pipe.ts

mkdir -p src/shared/filters
touch src/shared/filters/global-exception.filter.ts

mkdir -p src/shared/pagination
touch src/shared/pagination/pagination.dto.ts
touch src/shared/pagination/paginated-result.ts

mkdir -p src/shared/types
touch src/shared/types/express.d.ts
touch src/shared/types/api-response.type.ts
touch src/shared/types/authenticated-request.ts

mkdir -p src/shared/utils
touch src/shared/utils/crypto.util.ts
touch src/shared/utils/date.util.ts
touch src/shared/utils/geo.util.ts
touch src/shared/utils/string.util.ts
touch src/shared/utils/validator.util.ts

# =============================================
# src/health
# =============================================
mkdir -p src/health/indicators
touch src/health/health.controller.ts
touch src/health/indicators/database.indicator.ts
touch src/health/indicators/redis.indicator.ts
touch src/health/indicators/queue.indicator.ts

# =============================================
# src root files
# =============================================
touch src/app.ts
touch src/main.ts

# =============================================
# tests
# =============================================
mkdir -p tests/unit
mkdir -p tests/integration
mkdir -p tests/e2e
mkdir -p tests/fixtures

# =============================================
# scripts
# =============================================
mkdir -p scripts
touch scripts/db-reset.sh
touch scripts/generate-types.sh
touch scripts/deploy.sh
chmod +x scripts/db-reset.sh
chmod +x scripts/generate-types.sh
chmod +x scripts/deploy.sh

# =============================================
# docs
# =============================================
mkdir -p docs/adr
touch docs/architecture.md
touch docs/api-guide.md
touch docs/adr/001-fastify-over-express.md
touch docs/adr/002-prisma-orm.md

# =============================================
# Root config files
# =============================================
touch .env.example
touch .env.development
touch .env.test
touch .eslintrc.ts
touch .prettierrc
touch commitlint.config.ts
touch tsconfig.json
touch tsconfig.build.json
touch vitest.config.ts
touch package.json
touch README.md

# =============================================
# .gitignore
# =============================================
cat > .gitignore << 'EOF'
node_modules/
dist/
.env
.env.development
.env.production
.env.test
*.log
coverage/
.nyc_output/
EOF

echo ""
echo "============================================="
echo "âœ… Structure crÃ©Ã©e avec succÃ¨s !"
echo "============================================="
echo ""
echo "í³ Dossiers crÃ©Ã©s :"
find . -type d | grep -v node_modules | grep -v ".git" | wc -l
echo ""
echo "ï¿½ï¿½ Fichiers crÃ©Ã©s :"
find . -type f | grep -v node_modules | grep -v ".git" | wc -l
echo ""
echo "í¾¯ Prochaines Ã©tapes :"
echo "  1. cd $PROJECT_NAME"
echo "  2. npm init -y"
echo "  3. npm install fastify typescript prisma @prisma/client"
echo "  4. npm install -D ts-node vitest @types/node"
echo "  5. npx prisma init"
echo "  6. Bon dÃ©veloppement ! íº€"
