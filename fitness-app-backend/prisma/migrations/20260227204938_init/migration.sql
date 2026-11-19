-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('active', 'inactive', 'suspended', 'deleted');

-- CreateEnum
CREATE TYPE "GenderType" AS ENUM ('male', 'female', 'other', 'prefer_not_to_say');

-- CreateEnum
CREATE TYPE "FitnessLevel" AS ENUM ('beginner', 'intermediate', 'advanced', 'expert');

-- CreateEnum
CREATE TYPE "ActivityLevel" AS ENUM ('sedentary', 'lightly_active', 'moderately_active', 'very_active', 'extremely_active');

-- CreateEnum
CREATE TYPE "GoalType" AS ENUM ('weight_loss', 'muscle_gain', 'endurance', 'flexibility', 'health', 'custom');

-- CreateEnum
CREATE TYPE "GoalStatus" AS ENUM ('active', 'completed', 'paused', 'abandoned');

-- CreateEnum
CREATE TYPE "PriorityType" AS ENUM ('low', 'medium', 'high');

-- CreateEnum
CREATE TYPE "PlanType" AS ENUM ('ai_generated', 'custom', 'template');

-- CreateEnum
CREATE TYPE "PlanStatus" AS ENUM ('active', 'completed', 'paused', 'draft');

-- CreateEnum
CREATE TYPE "ExerciseCategory" AS ENUM ('cardio', 'strength', 'flexibility', 'balance', 'sports', 'meditation', 'other');

-- CreateEnum
CREATE TYPE "DifficultyLevel" AS ENUM ('beginner', 'intermediate', 'advanced', 'expert');

-- CreateEnum
CREATE TYPE "SessionStatus" AS ENUM ('scheduled', 'completed', 'skipped', 'in_progress');

-- CreateEnum
CREATE TYPE "MoodType" AS ENUM ('great', 'good', 'okay', 'tired', 'exhausted', 'energized');

-- CreateEnum
CREATE TYPE "EventType" AS ENUM ('group_workout', 'competition', 'workshop', 'social', 'challenge', 'other');

-- CreateEnum
CREATE TYPE "LocationType" AS ENUM ('physical', 'virtual', 'hybrid');

-- CreateEnum
CREATE TYPE "EventStatus" AS ENUM ('draft', 'published', 'cancelled', 'completed');

-- CreateEnum
CREATE TYPE "RegistrationStatus" AS ENUM ('registered', 'waitlist', 'confirmed', 'cancelled', 'attended');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('pending', 'completed', 'refunded', 'free');

-- CreateEnum
CREATE TYPE "ConversationType" AS ENUM ('direct', 'group', 'ai_coach', 'event');

-- CreateEnum
CREATE TYPE "ParticipantRole" AS ENUM ('member', 'admin', 'owner');

-- CreateEnum
CREATE TYPE "MessageType" AS ENUM ('text', 'image', 'video', 'audio', 'file', 'system', 'story');

-- CreateEnum
CREATE TYPE "StoryType" AS ENUM ('image', 'video', 'text', 'workout_achievement', 'goal_milestone');

-- CreateEnum
CREATE TYPE "StoryStatus" AS ENUM ('active', 'expired', 'deleted');

-- CreateEnum
CREATE TYPE "FriendshipStatus" AS ENUM ('pending', 'accepted', 'blocked', 'rejected');

-- CreateEnum
CREATE TYPE "RouteType" AS ENUM ('running', 'cycling', 'walking', 'hiking', 'other');

-- CreateEnum
CREATE TYPE "PrivacyType" AS ENUM ('private', 'friends', 'public');

-- CreateEnum
CREATE TYPE "TerrainType" AS ENUM ('road', 'trail', 'mixed');

-- CreateEnum
CREATE TYPE "ScheduleType" AS ENUM ('workout', 'meal', 'event', 'mixed');

-- CreateEnum
CREATE TYPE "ItemType" AS ENUM ('workout', 'meal', 'event', 'reminder', 'custom');

-- CreateEnum
CREATE TYPE "ItemStatus" AS ENUM ('scheduled', 'completed', 'cancelled', 'rescheduled');

-- CreateEnum
CREATE TYPE "NotificationType" AS ENUM ('friend_request', 'message', 'event', 'workout_reminder', 'achievement', 'ai_recommendation', 'system');

-- CreateEnum
CREATE TYPE "NotificationPriority" AS ENUM ('low', 'normal', 'high', 'urgent');

-- CreateEnum
CREATE TYPE "AchievementCategory" AS ENUM ('distance', 'frequency', 'duration', 'weight', 'social', 'streak', 'special');

-- CreateEnum
CREATE TYPE "RarityType" AS ENUM ('common', 'uncommon', 'rare', 'epic', 'legendary');

-- CreateEnum
CREATE TYPE "CollaboratorStatus" AS ENUM ('active', 'inactive', 'pending_approval');

-- CreateEnum
CREATE TYPE "PriceRange" AS ENUM ('budget', 'moderate', 'expensive', 'luxury');

-- CreateEnum
CREATE TYPE "RecommendationType" AS ENUM ('workout', 'nutrition', 'event', 'collaborator', 'general');

-- CreateEnum
CREATE TYPE "RecommendationStatus" AS ENUM ('pending', 'viewed', 'accepted', 'dismissed');

-- CreateEnum
CREATE TYPE "ReviewStatus" AS ENUM ('pending', 'approved', 'rejected', 'flagged');

-- CreateTable
CREATE TABLE "users" (
    "user_id" BIGSERIAL NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password_hash" VARCHAR(255) NOT NULL,
    "username" VARCHAR(100) NOT NULL,
    "phone" VARCHAR(20),
    "status" "UserStatus" NOT NULL DEFAULT 'active',
    "email_verified" BOOLEAN NOT NULL DEFAULT false,
    "phone_verified" BOOLEAN NOT NULL DEFAULT false,
    "profile_completed" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "last_login" TIMESTAMP(3),

    CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "user_profiles" (
    "profile_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "first_name" VARCHAR(100),
    "last_name" VARCHAR(100),
    "date_of_birth" DATE,
    "gender" "GenderType",
    "profile_picture_url" VARCHAR(500),
    "bio" TEXT,
    "address_line1" VARCHAR(255),
    "address_line2" VARCHAR(255),
    "city" VARCHAR(100),
    "state" VARCHAR(100),
    "postal_code" VARCHAR(20),
    "country" VARCHAR(100),
    "latitude" DECIMAL(10,8),
    "longitude" DECIMAL(11,8),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_profiles_pkey" PRIMARY KEY ("profile_id")
);

-- CreateTable
CREATE TABLE "health_profiles" (
    "health_profile_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "height" DECIMAL(5,2),
    "weight" DECIMAL(5,2),
    "fitness_level" "FitnessLevel" NOT NULL DEFAULT 'beginner',
    "activity_level" "ActivityLevel",
    "allergies" JSONB,
    "medical_conditions" JSONB,
    "medications" JSONB,
    "emergency_contact_name" VARCHAR(255),
    "emergency_contact_phone" VARCHAR(20),
    "emergency_contact_relation" VARCHAR(100),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "health_profiles_pkey" PRIMARY KEY ("health_profile_id")
);

-- CreateTable
CREATE TABLE "user_preferences" (
    "preference_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "preferred_workout_time" VARCHAR(20),
    "preferred_workout_duration" INTEGER,
    "workout_frequency_per_week" INTEGER,
    "preferred_workout_types" JSONB,
    "dietary_preferences" JSONB,
    "notification_enabled" BOOLEAN NOT NULL DEFAULT true,
    "notification_types" JSONB,
    "language" VARCHAR(10) NOT NULL DEFAULT 'fr',
    "timezone" VARCHAR(50) NOT NULL DEFAULT 'Europe/Paris',
    "unit_system" VARCHAR(20) NOT NULL DEFAULT 'metric',
    "vr_preference" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_preferences_pkey" PRIMARY KEY ("preference_id")
);

-- CreateTable
CREATE TABLE "goals" (
    "goal_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "goal_type" "GoalType" NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "target_value" DECIMAL(10,2),
    "current_value" DECIMAL(10,2),
    "unit" VARCHAR(50),
    "start_date" DATE,
    "target_date" DATE,
    "status" "GoalStatus" NOT NULL DEFAULT 'active',
    "priority" "PriorityType" NOT NULL DEFAULT 'medium',
    "is_primary" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "goals_pkey" PRIMARY KEY ("goal_id")
);

-- CreateTable
CREATE TABLE "training_plans" (
    "plan_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "goal_id" BIGINT,
    "plan_name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "plan_type" "PlanType" NOT NULL DEFAULT 'ai_generated',
    "difficulty_level" "DifficultyLevel",
    "duration_weeks" INTEGER,
    "start_date" DATE,
    "end_date" DATE,
    "status" "PlanStatus" NOT NULL DEFAULT 'draft',
    "ai_model_version" VARCHAR(50),
    "customization_score" DECIMAL(3,2),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "training_plans_pkey" PRIMARY KEY ("plan_id")
);

-- CreateTable
CREATE TABLE "exercises" (
    "exercise_id" BIGSERIAL NOT NULL,
    "exercise_name" VARCHAR(255) NOT NULL,
    "category" "ExerciseCategory",
    "description" TEXT,
    "instructions" TEXT,
    "difficulty" "DifficultyLevel",
    "equipment_needed" JSONB,
    "muscle_groups" JSONB,
    "calories_per_minute" DECIMAL(5,2),
    "video_url" VARCHAR(500),
    "image_url" VARCHAR(500),
    "is_vr_compatible" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "exercises_pkey" PRIMARY KEY ("exercise_id")
);

-- CreateTable
CREATE TABLE "workout_sessions" (
    "session_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "plan_id" BIGINT,
    "session_date" DATE NOT NULL,
    "session_time" TIME,
    "duration_minutes" INTEGER,
    "calories_burned" DECIMAL(6,2),
    "status" "SessionStatus" NOT NULL DEFAULT 'scheduled',
    "notes" TEXT,
    "rating" INTEGER,
    "difficulty_rating" INTEGER,
    "mood_before" "MoodType",
    "mood_after" "MoodType",
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "workout_sessions_pkey" PRIMARY KEY ("session_id")
);

-- CreateTable
CREATE TABLE "session_exercises" (
    "session_exercise_id" BIGSERIAL NOT NULL,
    "session_id" BIGINT NOT NULL,
    "exercise_id" BIGINT NOT NULL,
    "order_index" INTEGER NOT NULL,
    "sets" INTEGER,
    "reps" INTEGER,
    "duration_minutes" INTEGER,
    "weight_kg" DECIMAL(6,2),
    "distance_km" DECIMAL(6,2),
    "speed_kmh" DECIMAL(5,2),
    "rest_seconds" INTEGER,
    "notes" TEXT,
    "completed" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "session_exercises_pkey" PRIMARY KEY ("session_exercise_id")
);

-- CreateTable
CREATE TABLE "ai_recommendations" (
    "recommendation_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "recommendation_type" "RecommendationType" NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "ai_confidence_score" DECIMAL(3,2),
    "priority" "PriorityType" NOT NULL DEFAULT 'medium',
    "status" "RecommendationStatus" NOT NULL DEFAULT 'pending',
    "related_entity_type" VARCHAR(50),
    "related_entity_id" BIGINT,
    "metadata" JSONB,
    "expires_at" TIMESTAMP(3),
    "viewed_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ai_recommendations_pkey" PRIMARY KEY ("recommendation_id")
);

-- CreateTable
CREATE TABLE "events" (
    "event_id" BIGSERIAL NOT NULL,
    "organizer_id" BIGINT NOT NULL,
    "event_name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "event_type" "EventType",
    "location_type" "LocationType",
    "venue_name" VARCHAR(255),
    "address" TEXT,
    "latitude" DECIMAL(10,8),
    "longitude" DECIMAL(11,8),
    "virtual_link" VARCHAR(500),
    "is_vr" BOOLEAN NOT NULL DEFAULT false,
    "start_datetime" TIMESTAMP(3) NOT NULL,
    "end_datetime" TIMESTAMP(3) NOT NULL,
    "max_participants" INTEGER,
    "current_participants" INTEGER NOT NULL DEFAULT 0,
    "registration_deadline" TIMESTAMP(3),
    "price" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "currency" VARCHAR(3) NOT NULL DEFAULT 'EUR',
    "image_url" VARCHAR(500),
    "status" "EventStatus" NOT NULL DEFAULT 'draft',
    "is_ai_recommended" BOOLEAN NOT NULL DEFAULT false,
    "tags" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "events_pkey" PRIMARY KEY ("event_id")
);

-- CreateTable
CREATE TABLE "event_participants" (
    "participant_id" BIGSERIAL NOT NULL,
    "event_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "registration_status" "RegistrationStatus" NOT NULL DEFAULT 'registered',
    "payment_status" "PaymentStatus" NOT NULL DEFAULT 'free',
    "notes" TEXT,
    "registered_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "attended_at" TIMESTAMP(3),

    CONSTRAINT "event_participants_pkey" PRIMARY KEY ("participant_id")
);

-- CreateTable
CREATE TABLE "conversations" (
    "conversation_id" BIGSERIAL NOT NULL,
    "conversation_type" "ConversationType" NOT NULL,
    "conversation_name" VARCHAR(255),
    "is_ai_coach" BOOLEAN NOT NULL DEFAULT false,
    "created_by" BIGINT NOT NULL,
    "last_message_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "conversations_pkey" PRIMARY KEY ("conversation_id")
);

-- CreateTable
CREATE TABLE "conversation_participants" (
    "participant_id" BIGSERIAL NOT NULL,
    "conversation_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "role" "ParticipantRole" NOT NULL DEFAULT 'member',
    "joined_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "last_read_at" TIMESTAMP(3),
    "is_muted" BOOLEAN NOT NULL DEFAULT false,
    "is_archived" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "conversation_participants_pkey" PRIMARY KEY ("participant_id")
);

-- CreateTable
CREATE TABLE "messages" (
    "message_id" BIGSERIAL NOT NULL,
    "conversation_id" BIGINT NOT NULL,
    "sender_id" BIGINT NOT NULL,
    "message_type" "MessageType" NOT NULL DEFAULT 'text',
    "content" TEXT,
    "media_url" VARCHAR(500),
    "media_type" VARCHAR(50),
    "media_size_bytes" BIGINT,
    "is_ai_generated" BOOLEAN NOT NULL DEFAULT false,
    "ai_model_version" VARCHAR(50),
    "reply_to_message_id" BIGINT,
    "is_edited" BOOLEAN NOT NULL DEFAULT false,
    "edited_at" TIMESTAMP(3),
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "deleted_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "messages_pkey" PRIMARY KEY ("message_id")
);

-- CreateTable
CREATE TABLE "stories" (
    "story_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "story_type" "StoryType" NOT NULL,
    "content" TEXT,
    "media_url" VARCHAR(500),
    "thumbnail_url" VARCHAR(500),
    "duration_seconds" INTEGER,
    "view_count" INTEGER NOT NULL DEFAULT 0,
    "is_interactive" BOOLEAN NOT NULL DEFAULT false,
    "interaction_data" JSONB,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "status" "StoryStatus" NOT NULL DEFAULT 'active',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "stories_pkey" PRIMARY KEY ("story_id")
);

-- CreateTable
CREATE TABLE "story_views" (
    "view_id" BIGSERIAL NOT NULL,
    "story_id" BIGINT NOT NULL,
    "viewer_id" BIGINT NOT NULL,
    "viewed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "interaction_data" JSONB,

    CONSTRAINT "story_views_pkey" PRIMARY KEY ("view_id")
);

-- CreateTable
CREATE TABLE "friendships" (
    "friendship_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "friend_id" BIGINT NOT NULL,
    "status" "FriendshipStatus" NOT NULL DEFAULT 'pending',
    "requested_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "accepted_at" TIMESTAMP(3),

    CONSTRAINT "friendships_pkey" PRIMARY KEY ("friendship_id")
);

-- CreateTable
CREATE TABLE "collaborator_types" (
    "type_id" BIGSERIAL NOT NULL,
    "type_name" VARCHAR(100) NOT NULL,
    "type_slug" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "icon_url" VARCHAR(500),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "collaborator_types_pkey" PRIMARY KEY ("type_id")
);

-- CreateTable
CREATE TABLE "collaborators" (
    "collaborator_id" BIGSERIAL NOT NULL,
    "type_id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "logo_url" VARCHAR(500),
    "cover_image_url" VARCHAR(500),
    "phone" VARCHAR(20),
    "email" VARCHAR(255),
    "website" VARCHAR(500),
    "address_line1" VARCHAR(255),
    "city" VARCHAR(100),
    "country" VARCHAR(100),
    "latitude" DECIMAL(10,8),
    "longitude" DECIMAL(11,8),
    "rating" DECIMAL(3,2),
    "review_count" INTEGER NOT NULL DEFAULT 0,
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "is_premium_partner" BOOLEAN NOT NULL DEFAULT false,
    "business_hours" JSONB,
    "amenities" JSONB,
    "price_range" "PriceRange",
    "status" "CollaboratorStatus" NOT NULL DEFAULT 'pending_approval',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "collaborators_pkey" PRIMARY KEY ("collaborator_id")
);

-- CreateTable
CREATE TABLE "collaborator_reviews" (
    "review_id" BIGSERIAL NOT NULL,
    "collaborator_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "rating" INTEGER NOT NULL,
    "title" VARCHAR(255),
    "comment" TEXT,
    "visit_date" DATE,
    "is_verified_visit" BOOLEAN NOT NULL DEFAULT false,
    "helpful_count" INTEGER NOT NULL DEFAULT 0,
    "images" JSONB,
    "status" "ReviewStatus" NOT NULL DEFAULT 'pending',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "collaborator_reviews_pkey" PRIMARY KEY ("review_id")
);

-- CreateTable
CREATE TABLE "user_favorite_collaborators" (
    "favorite_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "collaborator_id" BIGINT NOT NULL,
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_favorite_collaborators_pkey" PRIMARY KEY ("favorite_id")
);

-- CreateTable
CREATE TABLE "routes" (
    "route_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "route_name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "route_type" "RouteType",
    "is_shared" BOOLEAN NOT NULL DEFAULT false,
    "privacy" "PrivacyType" NOT NULL DEFAULT 'private',
    "start_location_name" VARCHAR(255),
    "start_latitude" DECIMAL(10,8),
    "start_longitude" DECIMAL(11,8),
    "end_location_name" VARCHAR(255),
    "end_latitude" DECIMAL(10,8),
    "end_longitude" DECIMAL(11,8),
    "distance_km" DECIMAL(8,2),
    "elevation_gain_m" DECIMAL(8,2),
    "estimated_duration_minutes" INTEGER,
    "difficulty" "DifficultyLevel",
    "route_data" JSONB,
    "terrain_type" "TerrainType",
    "is_loop" BOOLEAN NOT NULL DEFAULT false,
    "surface_types" JSONB,
    "landmarks" JSONB,
    "image_url" VARCHAR(500),
    "view_count" INTEGER NOT NULL DEFAULT 0,
    "like_count" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "routes_pkey" PRIMARY KEY ("route_id")
);

-- CreateTable
CREATE TABLE "route_shares" (
    "share_id" BIGSERIAL NOT NULL,
    "route_id" BIGINT NOT NULL,
    "shared_by_user_id" BIGINT NOT NULL,
    "shared_with_user_id" BIGINT NOT NULL,
    "message" TEXT,
    "shared_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "route_shares_pkey" PRIMARY KEY ("share_id")
);

-- CreateTable
CREATE TABLE "route_activities" (
    "activity_id" BIGSERIAL NOT NULL,
    "route_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "activity_date" TIMESTAMP(3) NOT NULL,
    "duration_minutes" INTEGER,
    "distance_km" DECIMAL(8,2),
    "average_pace" VARCHAR(20),
    "average_speed_kmh" DECIMAL(5,2),
    "max_speed_kmh" DECIMAL(5,2),
    "calories_burned" DECIMAL(6,2),
    "average_heart_rate" INTEGER,
    "max_heart_rate" INTEGER,
    "elevation_gain_m" DECIMAL(8,2),
    "weather_conditions" VARCHAR(100),
    "temperature_celsius" DECIMAL(4,1),
    "notes" TEXT,
    "gps_data" JSONB,
    "photos" JSONB,
    "is_shared" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "route_activities_pkey" PRIMARY KEY ("activity_id")
);

-- CreateTable
CREATE TABLE "custom_schedules" (
    "schedule_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "schedule_name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "scheduleType" "ScheduleType",
    "is_vr" BOOLEAN NOT NULL DEFAULT false,
    "start_date" DATE,
    "end_date" DATE,
    "recurrence_pattern" JSONB,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "custom_schedules_pkey" PRIMARY KEY ("schedule_id")
);

-- CreateTable
CREATE TABLE "schedule_items" (
    "item_id" BIGSERIAL NOT NULL,
    "schedule_id" BIGINT NOT NULL,
    "item_type" "ItemType",
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "scheduled_date" DATE NOT NULL,
    "scheduled_time" TIME,
    "duration_minutes" INTEGER,
    "location" VARCHAR(255),
    "is_vr" BOOLEAN NOT NULL DEFAULT false,
    "related_entity_type" VARCHAR(50),
    "related_entity_id" BIGINT,
    "status" "ItemStatus" NOT NULL DEFAULT 'scheduled',
    "reminder_minutes_before" INTEGER,
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "schedule_items_pkey" PRIMARY KEY ("item_id")
);

-- CreateTable
CREATE TABLE "user_metrics" (
    "metric_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "metric_date" DATE NOT NULL,
    "weight_kg" DECIMAL(5,2),
    "body_fat_percentage" DECIMAL(4,2),
    "muscle_mass_kg" DECIMAL(5,2),
    "bmi" DECIMAL(4,2),
    "waist_cm" DECIMAL(5,2),
    "chest_cm" DECIMAL(5,2),
    "arms_cm" DECIMAL(5,2),
    "thighs_cm" DECIMAL(5,2),
    "resting_heart_rate" INTEGER,
    "blood_pressure_systolic" INTEGER,
    "blood_pressure_diastolic" INTEGER,
    "vo2_max" DECIMAL(5,2),
    "sleep_hours" DECIMAL(4,2),
    "water_intake_liters" DECIMAL(4,2),
    "stress_level" INTEGER,
    "energy_level" INTEGER,
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_metrics_pkey" PRIMARY KEY ("metric_id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "notification_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "notification_type" "NotificationType" NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "message" TEXT,
    "is_read" BOOLEAN NOT NULL DEFAULT false,
    "action_url" VARCHAR(500),
    "related_entity_type" VARCHAR(50),
    "related_entity_id" BIGINT,
    "priority" "NotificationPriority" NOT NULL DEFAULT 'normal',
    "expires_at" TIMESTAMP(3),
    "read_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("notification_id")
);

-- CreateTable
CREATE TABLE "achievements" (
    "achievement_id" BIGSERIAL NOT NULL,
    "achievement_name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "category" "AchievementCategory",
    "criteria" JSONB,
    "badge_image_url" VARCHAR(500),
    "points" INTEGER NOT NULL DEFAULT 0,
    "rarity" "RarityType" NOT NULL DEFAULT 'common',
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "achievements_pkey" PRIMARY KEY ("achievement_id")
);

-- CreateTable
CREATE TABLE "user_achievements" (
    "user_achievement_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "achievement_id" BIGINT NOT NULL,
    "unlocked_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "progress_percentage" INTEGER NOT NULL DEFAULT 100,

    CONSTRAINT "user_achievements_pkey" PRIMARY KEY ("user_achievement_id")
);

-- CreateTable
CREATE TABLE "user_sessions" (
    "session_id" VARCHAR(255) NOT NULL,
    "user_id" BIGINT NOT NULL,
    "device_type" VARCHAR(100),
    "device_name" VARCHAR(255),
    "os" VARCHAR(100),
    "browser" VARCHAR(100),
    "ip_address" VARCHAR(45),
    "location_country" VARCHAR(100),
    "location_city" VARCHAR(100),
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "last_activity_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_sessions_pkey" PRIMARY KEY ("session_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "user_profiles_user_id_key" ON "user_profiles"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "health_profiles_user_id_key" ON "health_profiles"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_preferences_user_id_key" ON "user_preferences"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "event_participants_event_id_user_id_key" ON "event_participants"("event_id", "user_id");

-- CreateIndex
CREATE UNIQUE INDEX "conversation_participants_conversation_id_user_id_key" ON "conversation_participants"("conversation_id", "user_id");

-- CreateIndex
CREATE UNIQUE INDEX "story_views_story_id_viewer_id_key" ON "story_views"("story_id", "viewer_id");

-- CreateIndex
CREATE UNIQUE INDEX "friendships_user_id_friend_id_key" ON "friendships"("user_id", "friend_id");

-- CreateIndex
CREATE UNIQUE INDEX "collaborator_types_type_name_key" ON "collaborator_types"("type_name");

-- CreateIndex
CREATE UNIQUE INDEX "collaborator_types_type_slug_key" ON "collaborator_types"("type_slug");

-- CreateIndex
CREATE UNIQUE INDEX "user_favorite_collaborators_user_id_collaborator_id_key" ON "user_favorite_collaborators"("user_id", "collaborator_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_metrics_user_id_metric_date_key" ON "user_metrics"("user_id", "metric_date");

-- CreateIndex
CREATE UNIQUE INDEX "user_achievements_user_id_achievement_id_key" ON "user_achievements"("user_id", "achievement_id");

-- AddForeignKey
ALTER TABLE "user_profiles" ADD CONSTRAINT "user_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "health_profiles" ADD CONSTRAINT "health_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_preferences" ADD CONSTRAINT "user_preferences_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goals" ADD CONSTRAINT "goals_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "training_plans" ADD CONSTRAINT "training_plans_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "training_plans" ADD CONSTRAINT "training_plans_goal_id_fkey" FOREIGN KEY ("goal_id") REFERENCES "goals"("goal_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workout_sessions" ADD CONSTRAINT "workout_sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workout_sessions" ADD CONSTRAINT "workout_sessions_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "training_plans"("plan_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session_exercises" ADD CONSTRAINT "session_exercises_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "workout_sessions"("session_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session_exercises" ADD CONSTRAINT "session_exercises_exercise_id_fkey" FOREIGN KEY ("exercise_id") REFERENCES "exercises"("exercise_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ai_recommendations" ADD CONSTRAINT "ai_recommendations_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_organizer_id_fkey" FOREIGN KEY ("organizer_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "event_participants" ADD CONSTRAINT "event_participants_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "events"("event_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "event_participants" ADD CONSTRAINT "event_participants_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conversations" ADD CONSTRAINT "conversations_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conversation_participants" ADD CONSTRAINT "conversation_participants_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "conversations"("conversation_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conversation_participants" ADD CONSTRAINT "conversation_participants_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "conversations"("conversation_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_reply_to_message_id_fkey" FOREIGN KEY ("reply_to_message_id") REFERENCES "messages"("message_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stories" ADD CONSTRAINT "stories_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "story_views" ADD CONSTRAINT "story_views_story_id_fkey" FOREIGN KEY ("story_id") REFERENCES "stories"("story_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "story_views" ADD CONSTRAINT "story_views_viewer_id_fkey" FOREIGN KEY ("viewer_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "friendships" ADD CONSTRAINT "friendships_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "friendships" ADD CONSTRAINT "friendships_friend_id_fkey" FOREIGN KEY ("friend_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "collaborators" ADD CONSTRAINT "collaborators_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "collaborator_types"("type_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "collaborator_reviews" ADD CONSTRAINT "collaborator_reviews_collaborator_id_fkey" FOREIGN KEY ("collaborator_id") REFERENCES "collaborators"("collaborator_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "collaborator_reviews" ADD CONSTRAINT "collaborator_reviews_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_favorite_collaborators" ADD CONSTRAINT "user_favorite_collaborators_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_favorite_collaborators" ADD CONSTRAINT "user_favorite_collaborators_collaborator_id_fkey" FOREIGN KEY ("collaborator_id") REFERENCES "collaborators"("collaborator_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "routes" ADD CONSTRAINT "routes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_shares" ADD CONSTRAINT "route_shares_route_id_fkey" FOREIGN KEY ("route_id") REFERENCES "routes"("route_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_shares" ADD CONSTRAINT "route_shares_shared_by_user_id_fkey" FOREIGN KEY ("shared_by_user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_shares" ADD CONSTRAINT "route_shares_shared_with_user_id_fkey" FOREIGN KEY ("shared_with_user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_activities" ADD CONSTRAINT "route_activities_route_id_fkey" FOREIGN KEY ("route_id") REFERENCES "routes"("route_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_activities" ADD CONSTRAINT "route_activities_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "custom_schedules" ADD CONSTRAINT "custom_schedules_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "schedule_items" ADD CONSTRAINT "schedule_items_schedule_id_fkey" FOREIGN KEY ("schedule_id") REFERENCES "custom_schedules"("schedule_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_metrics" ADD CONSTRAINT "user_metrics_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_achievements" ADD CONSTRAINT "user_achievements_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_achievements" ADD CONSTRAINT "user_achievements_achievement_id_fkey" FOREIGN KEY ("achievement_id") REFERENCES "achievements"("achievement_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_sessions" ADD CONSTRAINT "user_sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;
