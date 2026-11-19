#!/bin/bash

# =============================================
# Setup Prisma Schema + Config complet
# Fitness App Backend - Prisma 7
# =============================================

echo "⚙️  Configuration Prisma 7..."

# =============================================
# prisma.config.ts COMPLET
# =============================================
cat > prisma.config.ts << 'EOF'
import path from 'node:path';
import { defineConfig } from 'prisma/config';
import 'dotenv/config';

const connectionString =
  process.env.DATABASE_URL ??
  'postgresql://postgres@localhost:5432/fitness_app';

export default defineConfig({
  schema: path.join('prisma', 'schema.prisma'),
  datasource: {
    url: connectionString,
  },
  migrate: {
    async adapter() {
      const { PrismaPg } = await import('@prisma/adapter-pg');
      return new PrismaPg({ connectionString });
    }
  },
  studio: {
    async adapter() {
      const { PrismaPg } = await import('@prisma/adapter-pg');
      return new PrismaPg({ connectionString });
    },
  },
});
EOF
echo "✅ prisma.config.ts"

# =============================================
# prisma/schema.prisma COMPLET
# =============================================
cat > prisma/schema.prisma << 'EOF'
generator client {
  provider        = "prisma-client-js"
  previewFeatures = ["driverAdapters"]
}

datasource db {
  provider = "postgresql"
}

// =============================================
// ENUMS
// =============================================

enum UserStatus {
  active
  inactive
  suspended
  deleted
}

enum GenderType {
  male
  female
  other
  prefer_not_to_say
}

enum FitnessLevel {
  beginner
  intermediate
  advanced
  expert
}

enum ActivityLevel {
  sedentary
  lightly_active
  moderately_active
  very_active
  extremely_active
}

enum GoalType {
  weight_loss
  muscle_gain
  endurance
  flexibility
  health
  custom
}

enum GoalStatus {
  active
  completed
  paused
  abandoned
}

enum PriorityType {
  low
  medium
  high
}

enum PlanType {
  ai_generated
  custom
  template
}

enum PlanStatus {
  active
  completed
  paused
  draft
}

enum ExerciseCategory {
  cardio
  strength
  flexibility
  balance
  sports
  meditation
  other
}

enum DifficultyLevel {
  beginner
  intermediate
  advanced
  expert
}

enum SessionStatus {
  scheduled
  completed
  skipped
  in_progress
}

enum MoodType {
  great
  good
  okay
  tired
  exhausted
  energized
}

enum EventType {
  group_workout
  competition
  workshop
  social
  challenge
  other
}

enum LocationType {
  physical
  virtual
  hybrid
}

enum EventStatus {
  draft
  published
  cancelled
  completed
}

enum RegistrationStatus {
  registered
  waitlist
  confirmed
  cancelled
  attended
}

enum PaymentStatus {
  pending
  completed
  refunded
  free
}

enum ConversationType {
  direct
  group
  ai_coach
  event
}

enum ParticipantRole {
  member
  admin
  owner
}

enum MessageType {
  text
  image
  video
  audio
  file
  system
  story
}

enum StoryType {
  image
  video
  text
  workout_achievement
  goal_milestone
}

enum StoryStatus {
  active
  expired
  deleted
}

enum FriendshipStatus {
  pending
  accepted
  blocked
  rejected
}

enum RouteType {
  running
  cycling
  walking
  hiking
  other
}

enum PrivacyType {
  private
  friends
  public
}

enum TerrainType {
  road
  trail
  mixed
}

enum ScheduleType {
  workout
  meal
  event
  mixed
}

enum ItemType {
  workout
  meal
  event
  reminder
  custom
}

enum ItemStatus {
  scheduled
  completed
  cancelled
  rescheduled
}

enum NotificationType {
  friend_request
  message
  event
  workout_reminder
  achievement
  ai_recommendation
  system
}

enum NotificationPriority {
  low
  normal
  high
  urgent
}

enum AchievementCategory {
  distance
  frequency
  duration
  weight
  social
  streak
  special
}

enum RarityType {
  common
  uncommon
  rare
  epic
  legendary
}

enum CollaboratorStatus {
  active
  inactive
  pending_approval
}

enum PriceRange {
  budget
  moderate
  expensive
  luxury
}

enum RecommendationType {
  workout
  nutrition
  event
  collaborator
  general
}

enum RecommendationStatus {
  pending
  viewed
  accepted
  dismissed
}

enum ReviewStatus {
  pending
  approved
  rejected
  flagged
}

// =============================================
// MODELS
// =============================================

model User {
  userId           BigInt     @id @default(autoincrement()) @map("user_id")
  email            String     @unique @db.VarChar(255)
  passwordHash     String     @map("password_hash") @db.VarChar(255)
  username         String     @unique @db.VarChar(100)
  phone            String?    @db.VarChar(20)
  status           UserStatus @default(active)
  emailVerified    Boolean    @default(false) @map("email_verified")
  phoneVerified    Boolean    @default(false) @map("phone_verified")
  profileCompleted Boolean    @default(false) @map("profile_completed")
  createdAt        DateTime   @default(now()) @map("created_at")
  updatedAt        DateTime   @updatedAt @map("updated_at")
  lastLogin        DateTime?  @map("last_login")

  profile                    UserProfile?
  healthProfile              HealthProfile?
  preferences                UserPreference?
  goals                      Goal[]
  trainingPlans              TrainingPlan[]
  workoutSessions            WorkoutSession[]
  eventsOrganized            Event[]
  eventParticipations        EventParticipant[]
  conversationsCreated       Conversation[]
  conversationParticipations ConversationParticipant[]
  messagesSent               Message[]
  stories                    Story[]
  storyViews                 StoryView[]
  friendships                Friendship[]              @relation("UserFriendships")
  friendOf                   Friendship[]              @relation("FriendFriendships")
  aiRecommendations          AiRecommendation[]
  metrics                    UserMetric[]
  notifications              Notification[]
  userAchievements           UserAchievement[]
  routes                     Route[]
  routeActivities            RouteActivity[]
  schedules                  CustomSchedule[]
  favoriteCollaborators      UserFavoriteCollaborator[]
  collaboratorReviews        CollaboratorReview[]
  sessions                   UserSession[]
  routeSharedBy              RouteShare[]              @relation("SharedBy")
  routeSharedWith            RouteShare[]              @relation("SharedWith")

  @@map("users")
}

model UserProfile {
  profileId         BigInt      @id @default(autoincrement()) @map("profile_id")
  userId            BigInt      @unique @map("user_id")
  firstName         String?     @map("first_name") @db.VarChar(100)
  lastName          String?     @map("last_name") @db.VarChar(100)
  dateOfBirth       DateTime?   @map("date_of_birth") @db.Date
  gender            GenderType?
  profilePictureUrl String?     @map("profile_picture_url") @db.VarChar(500)
  bio               String?     @db.Text
  addressLine1      String?     @map("address_line1") @db.VarChar(255)
  addressLine2      String?     @map("address_line2") @db.VarChar(255)
  city              String?     @db.VarChar(100)
  state             String?     @db.VarChar(100)
  postalCode        String?     @map("postal_code") @db.VarChar(20)
  country           String?     @db.VarChar(100)
  latitude          Decimal?    @db.Decimal(10, 8)
  longitude         Decimal?    @db.Decimal(11, 8)
  createdAt         DateTime    @default(now()) @map("created_at")
  updatedAt         DateTime    @updatedAt @map("updated_at")

  user              User        @relation(fields: [userId], references: [userId], onDelete: Cascade)

  @@map("user_profiles")
}

model HealthProfile {
  healthProfileId      BigInt        @id @default(autoincrement()) @map("health_profile_id")
  userId               BigInt        @unique @map("user_id")
  height               Decimal?      @db.Decimal(5, 2)
  weight               Decimal?      @db.Decimal(5, 2)
  fitnessLevel         FitnessLevel  @default(beginner) @map("fitness_level")
  activityLevel        ActivityLevel? @map("activity_level")
  allergies            Json?
  medicalConditions    Json?         @map("medical_conditions")
  medications          Json?
  emergencyContactName  String?      @map("emergency_contact_name") @db.VarChar(255)
  emergencyContactPhone String?      @map("emergency_contact_phone") @db.VarChar(20)
  emergencyContactRelation String?   @map("emergency_contact_relation") @db.VarChar(100)
  createdAt            DateTime      @default(now()) @map("created_at")
  updatedAt            DateTime      @updatedAt @map("updated_at")

  user                 User          @relation(fields: [userId], references: [userId], onDelete: Cascade)

  @@map("health_profiles")
}

model UserPreference {
  preferenceId              BigInt      @id @default(autoincrement()) @map("preference_id")
  userId                    BigInt      @unique @map("user_id")
  preferredWorkoutTime      String?     @map("preferred_workout_time") @db.VarChar(20)
  preferredWorkoutDuration  Int?        @map("preferred_workout_duration")
  workoutFrequencyPerWeek   Int?        @map("workout_frequency_per_week")
  preferredWorkoutTypes     Json?       @map("preferred_workout_types")
  dietaryPreferences        Json?       @map("dietary_preferences")
  notificationEnabled       Boolean     @default(true) @map("notification_enabled")
  notificationTypes         Json?       @map("notification_types")
  language                  String      @default("fr") @db.VarChar(10)
  timezone                  String      @default("Europe/Paris") @db.VarChar(50)
  unitSystem                String      @default("metric") @map("unit_system") @db.VarChar(20)
  vrPreference              Boolean     @default(false) @map("vr_preference")
  createdAt                 DateTime    @default(now()) @map("created_at")
  updatedAt                 DateTime    @updatedAt @map("updated_at")

  user                      User        @relation(fields: [userId], references: [userId], onDelete: Cascade)

  @@map("user_preferences")
}

model Goal {
  goalId        BigInt       @id @default(autoincrement()) @map("goal_id")
  userId        BigInt       @map("user_id")
  goalType      GoalType     @map("goal_type")
  title         String       @db.VarChar(255)
  description   String?      @db.Text
  targetValue   Decimal?     @map("target_value") @db.Decimal(10, 2)
  currentValue  Decimal?     @map("current_value") @db.Decimal(10, 2)
  unit          String?      @db.VarChar(50)
  startDate     DateTime?    @map("start_date") @db.Date
  targetDate    DateTime?    @map("target_date") @db.Date
  status        GoalStatus   @default(active)
  priority      PriorityType @default(medium)
  isPrimary     Boolean      @default(false) @map("is_primary")
  createdAt     DateTime     @default(now()) @map("created_at")
  updatedAt     DateTime     @updatedAt @map("updated_at")

  user          User         @relation(fields: [userId], references: [userId], onDelete: Cascade)
  trainingPlans TrainingPlan[]

  @@map("goals")
}

model TrainingPlan {
  planId             BigInt          @id @default(autoincrement()) @map("plan_id")
  userId             BigInt          @map("user_id")
  goalId             BigInt?         @map("goal_id")
  planName           String          @map("plan_name") @db.VarChar(255)
  description        String?         @db.Text
  planType           PlanType        @default(ai_generated) @map("plan_type")
  difficultyLevel    DifficultyLevel? @map("difficulty_level")
  durationWeeks      Int?            @map("duration_weeks")
  startDate          DateTime?       @map("start_date") @db.Date
  endDate            DateTime?       @map("end_date") @db.Date
  status             PlanStatus      @default(draft)
  aiModelVersion     String?         @map("ai_model_version") @db.VarChar(50)
  customizationScore Decimal?        @map("customization_score") @db.Decimal(3, 2)
  createdAt          DateTime        @default(now()) @map("created_at")
  updatedAt          DateTime        @updatedAt @map("updated_at")

  user               User            @relation(fields: [userId], references: [userId], onDelete: Cascade)
  goal               Goal?           @relation(fields: [goalId], references: [goalId], onDelete: SetNull)
  workoutSessions    WorkoutSession[]

  @@map("training_plans")
}

model Exercise {
  exerciseId        BigInt            @id @default(autoincrement()) @map("exercise_id")
  exerciseName      String            @map("exercise_name") @db.VarChar(255)
  category          ExerciseCategory?
  description       String?           @db.Text
  instructions      String?           @db.Text
  difficulty        DifficultyLevel?
  equipmentNeeded   Json?             @map("equipment_needed")
  muscleGroups      Json?             @map("muscle_groups")
  caloriesPerMinute Decimal?          @map("calories_per_minute") @db.Decimal(5, 2)
  videoUrl          String?           @map("video_url") @db.VarChar(500)
  imageUrl          String?           @map("image_url") @db.VarChar(500)
  isVrCompatible    Boolean           @default(false) @map("is_vr_compatible")
  createdAt         DateTime          @default(now()) @map("created_at")
  updatedAt         DateTime          @updatedAt @map("updated_at")

  sessionExercises  SessionExercise[]

  @@map("exercises")
}

model WorkoutSession {
  sessionId        BigInt        @id @default(autoincrement()) @map("session_id")
  userId           BigInt        @map("user_id")
  planId           BigInt?       @map("plan_id")
  sessionDate      DateTime      @map("session_date") @db.Date
  sessionTime      DateTime?     @map("session_time") @db.Time
  durationMinutes  Int?          @map("duration_minutes")
  caloriesBurned   Decimal?      @map("calories_burned") @db.Decimal(6, 2)
  status           SessionStatus @default(scheduled)
  notes            String?       @db.Text
  rating           Int?
  difficultyRating Int?          @map("difficulty_rating")
  moodBefore       MoodType?     @map("mood_before")
  moodAfter        MoodType?     @map("mood_after")
  createdAt        DateTime      @default(now()) @map("created_at")
  updatedAt        DateTime      @updatedAt @map("updated_at")

  user             User          @relation(fields: [userId], references: [userId], onDelete: Cascade)
  plan             TrainingPlan? @relation(fields: [planId], references: [planId], onDelete: SetNull)
  exercises        SessionExercise[]

  @@map("workout_sessions")
}

model SessionExercise {
  sessionExerciseId BigInt         @id @default(autoincrement()) @map("session_exercise_id")
  sessionId         BigInt         @map("session_id")
  exerciseId        BigInt         @map("exercise_id")
  orderIndex        Int            @map("order_index")
  sets              Int?
  reps              Int?
  durationMinutes   Int?           @map("duration_minutes")
  weightKg          Decimal?       @map("weight_kg") @db.Decimal(6, 2)
  distanceKm        Decimal?       @map("distance_km") @db.Decimal(6, 2)
  speedKmh          Decimal?       @map("speed_kmh") @db.Decimal(5, 2)
  restSeconds       Int?           @map("rest_seconds")
  notes             String?        @db.Text
  completed         Boolean        @default(false)
  createdAt         DateTime       @default(now()) @map("created_at")

  session           WorkoutSession @relation(fields: [sessionId], references: [sessionId], onDelete: Cascade)
  exercise          Exercise       @relation(fields: [exerciseId], references: [exerciseId], onDelete: Cascade)

  @@map("session_exercises")
}

model AiRecommendation {
  recommendationId   BigInt               @id @default(autoincrement()) @map("recommendation_id")
  userId             BigInt               @map("user_id")
  recommendationType RecommendationType   @map("recommendation_type")
  title              String               @db.VarChar(255)
  description        String?              @db.Text
  aiConfidenceScore  Decimal?             @map("ai_confidence_score") @db.Decimal(3, 2)
  priority           PriorityType         @default(medium)
  status             RecommendationStatus @default(pending)
  relatedEntityType  String?              @map("related_entity_type") @db.VarChar(50)
  relatedEntityId    BigInt?              @map("related_entity_id")
  metadata           Json?
  expiresAt          DateTime?            @map("expires_at")
  viewedAt           DateTime?            @map("viewed_at")
  createdAt          DateTime             @default(now()) @map("created_at")

  user               User                 @relation(fields: [userId], references: [userId], onDelete: Cascade)

  @@map("ai_recommendations")
}

model Event {
  eventId              BigInt               @id @default(autoincrement()) @map("event_id")
  organizerId          BigInt               @map("organizer_id")
  eventName            String               @map("event_name") @db.VarChar(255)
  description          String?              @db.Text
  eventType            EventType?           @map("event_type")
  locationType         LocationType?        @map("location_type")
  venueName            String?              @map("venue_name") @db.VarChar(255)
  address              String?              @db.Text
  latitude             Decimal?             @db.Decimal(10, 8)
  longitude            Decimal?             @db.Decimal(11, 8)
  virtualLink          String?              @map("virtual_link") @db.VarChar(500)
  isVr                 Boolean              @default(false) @map("is_vr")
  startDatetime        DateTime             @map("start_datetime")
  endDatetime          DateTime             @map("end_datetime")
  maxParticipants      Int?                 @map("max_participants")
  currentParticipants  Int                  @default(0) @map("current_participants")
  registrationDeadline DateTime?            @map("registration_deadline")
  price                Decimal              @default(0) @db.Decimal(10, 2)
  currency             String               @default("EUR") @db.VarChar(3)
  imageUrl             String?              @map("image_url") @db.VarChar(500)
  status               EventStatus          @default(draft)
  isAiRecommended      Boolean              @default(false) @map("is_ai_recommended")
  tags                 Json?
  createdAt            DateTime             @default(now()) @map("created_at")
  updatedAt            DateTime             @updatedAt @map("updated_at")

  organizer            User                 @relation(fields: [organizerId], references: [userId], onDelete: Cascade)
  participants         EventParticipant[]

  @@map("events")
}

model EventParticipant {
  participantId      BigInt             @id @default(autoincrement()) @map("participant_id")
  eventId            BigInt             @map("event_id")
  userId             BigInt             @map("user_id")
  registrationStatus RegistrationStatus @default(registered) @map("registration_status")
  paymentStatus      PaymentStatus      @default(free) @map("payment_status")
  notes              String?            @db.Text
  registeredAt       DateTime           @default(now()) @map("registered_at")
  attendedAt         DateTime?          @map("attended_at")

  event              Event              @relation(fields: [eventId], references: [eventId], onDelete: Cascade)
  user               User               @relation(fields: [userId], references: [userId], onDelete: Cascade)

  @@unique([eventId, userId])
  @@map("event_participants")
}

model Conversation {
  conversationId   BigInt              @id @default(autoincrement()) @map("conversation_id")
  conversationType ConversationType    @map("conversation_type")
  conversationName String?             @map("conversation_name") @db.VarChar(255)
  isAiCoach        Boolean             @default(false) @map("is_ai_coach")
  createdBy        BigInt              @map("created_by")
  lastMessageAt    DateTime?           @map("last_message_at")
  createdAt        DateTime            @default(now()) @map("created_at")
  updatedAt        DateTime            @updatedAt @map("updated_at")

  creator          User                @relation(fields: [createdBy], references: [userId], onDelete: Cascade)
  participants     ConversationParticipant[]
  messages         Message[]

  @@map("conversations")
}

model ConversationParticipant {
  participantId  BigInt          @id @default(autoincrement()) @map("participant_id")
  conversationId BigInt          @map("conversation_id")
  userId         BigInt          @map("user_id")
  role           ParticipantRole @default(member)
  joinedAt       DateTime        @default(now()) @map("joined_at")
  lastReadAt     DateTime?       @map("last_read_at")
  isMuted        Boolean         @default(false) @map("is_muted")
  isArchived     Boolean         @default(false) @map("is_archived")

  conversation   Conversation    @relation(fields: [conversationId], references: [conversationId], onDelete: Cascade)
  user           User            @relation(fields: [userId], references: [userId], onDelete: Cascade)

  @@unique([conversationId, userId])
  @@map("conversation_participants")
}

model Message {
  messageId        BigInt      @id @default(autoincrement()) @map("message_id")
  conversationId   BigInt      @map("conversation_id")
  senderId         BigInt      @map("sender_id")
  messageType      MessageType @default(text) @map("message_type")
  content          String?     @db.Text
  mediaUrl         String?     @map("media_url") @db.VarChar(500)
  mediaType        String?     @map("media_type") @db.VarChar(50)
  mediaSizeBytes   BigInt?     @map("media_size_bytes")
  isAiGenerated    Boolean     @default(false) @map("is_ai_generated")
  aiModelVersion   String?     @map("ai_model_version") @db.VarChar(50)
  replyToMessageId BigInt?     @map("reply_to_message_id")
  isEdited         Boolean     @default(false) @map("is_edited")
  editedAt         DateTime?   @map("edited_at")
  isDeleted        Boolean     @default(false) @map("is_deleted")
  deletedAt        DateTime?   @map("deleted_at")
  createdAt        DateTime    @default(now()) @map("created_at")

  conversation     Conversation @relation(fields: [conversationId], references: [conversationId], onDelete: Cascade)
  sender           User         @relation(fields: [senderId], references: [userId], onDelete: Cascade)
  replyTo          Message?     @relation("MessageReplies", fields: [replyToMessageId], references: [messageId], onDelete: SetNull)
  replies          Message[]    @relation("MessageReplies")

  @@map("messages")
}

model Story {
  storyId         BigInt      @id @default(autoincrement()) @map("story_id")
  userId          BigInt      @map("user_id")
  storyType       StoryType   @map("story_type")
  content         String?     @db.Text
  mediaUrl        String?     @map("media_url") @db.VarChar(500)
  thumbnailUrl    String?     @map("thumbnail_url") @db.VarChar(500)
  durationSeconds Int?        @map("duration_seconds")
  viewCount       Int         @default(0) @map("view_count")
  isInteractive   Boolean     @default(false) @map("is_interactive")
  interactionData Json?       @map("interaction_data")
  expiresAt       DateTime    @map("expires_at")
  status          StoryStatus @default(active)
  createdAt       DateTime    @default(now()) @map("created_at")

  user            User        @relation(fields: [userId], references: [userId], onDelete: Cascade)
  views           StoryView[]

  @@map("stories")
}

model StoryView {
  viewId          BigInt   @id @default(autoincrement()) @map("view_id")
  storyId         BigInt   @map("story_id")
  viewerId        BigInt   @map("viewer_id")
  viewedAt        DateTime @default(now()) @map("viewed_at")
  interactionData Json?    @map("interaction_data")

  story           Story    @relation(fields: [storyId], references: [storyId], onDelete: Cascade)
  viewer          User     @relation(fields: [viewerId], references: [userId], onDelete: Cascade)

  @@unique([storyId, viewerId])
  @@map("story_views")
}

model Friendship {
  friendshipId BigInt           @id @default(autoincrement()) @map("friendship_id")
  userId       BigInt           @map("user_id")
  friendId     BigInt           @map("friend_id")
  status       FriendshipStatus @default(pending)
  requestedAt  DateTime         @default(now()) @map("requested_at")
  acceptedAt   DateTime?        @map("accepted_at")

  user         User             @relation("UserFriendships", fields: [userId], references: [userId], onDelete: Cascade)
  friend       User             @relation("FriendFriendships", fields: [friendId], references: [userId], onDelete: Cascade)

  @@unique([userId, friendId])
  @@map("friendships")
}

model CollaboratorType {
  typeId        BigInt         @id @default(autoincrement()) @map("type_id")
  typeName      String         @unique @map("type_name") @db.VarChar(100)
  typeSlug      String         @unique @map("type_slug") @db.VarChar(100)
  description   String?        @db.Text
  iconUrl       String?        @map("icon_url") @db.VarChar(500)
  createdAt     DateTime       @default(now()) @map("created_at")

  collaborators Collaborator[]

  @@map("collaborator_types")
}

model Collaborator {
  collaboratorId   BigInt             @id @default(autoincrement()) @map("collaborator_id")
  typeId           BigInt             @map("type_id")
  name             String             @db.VarChar(255)
  description      String?            @db.Text
  logoUrl          String?            @map("logo_url") @db.VarChar(500)
  coverImageUrl    String?            @map("cover_image_url") @db.VarChar(500)
  phone            String?            @db.VarChar(20)
  email            String?            @db.VarChar(255)
  website          String?            @db.VarChar(500)
  addressLine1     String?            @map("address_line1") @db.VarChar(255)
  city             String?            @db.VarChar(100)
  country          String?            @db.VarChar(100)
  latitude         Decimal?           @db.Decimal(10, 8)
  longitude        Decimal?           @db.Decimal(11, 8)
  rating           Decimal?           @db.Decimal(3, 2)
  reviewCount      Int                @default(0) @map("review_count")
  isVerified       Boolean            @default(false) @map("is_verified")
  isPremiumPartner Boolean            @default(false) @map("is_premium_partner")
  businessHours    Json?              @map("business_hours")
  amenities        Json?
  priceRange       PriceRange?        @map("price_range")
  status           CollaboratorStatus @default(pending_approval)
  createdAt        DateTime           @default(now()) @map("created_at")
  updatedAt        DateTime           @updatedAt @map("updated_at")

  type             CollaboratorType   @relation(fields: [typeId], references: [typeId])
  reviews          CollaboratorReview[]
  favoritedBy      UserFavoriteCollaborator[]

  @@map("collaborators")
}

model CollaboratorReview {
  reviewId        BigInt       @id @default(autoincrement()) @map("review_id")
  collaboratorId  BigInt       @map("collaborator_id")
  userId          BigInt       @map("user_id")
  rating          Int
  title           String?      @db.VarChar(255)
  comment         String?      @db.Text
  visitDate       DateTime?    @map("visit_date") @db.Date
  isVerifiedVisit Boolean      @default(false) @map("is_verified_visit")
  helpfulCount    Int          @default(0) @map("helpful_count")
  images          Json?
  status          ReviewStatus @default(pending)
  createdAt       DateTime     @default(now()) @map("created_at")
  updatedAt       DateTime     @updatedAt @map("updated_at")

  collaborator    Collaborator @relation(fields: [collaboratorId], references: [collaboratorId], onDelete: Cascade)
  user            User         @relation(fields: [userId], references: [userId], onDelete: Cascade)

  @@map("collaborator_reviews")
}

model UserFavoriteCollaborator {
  favoriteId     BigInt       @id @default(autoincrement()) @map("favorite_id")
  userId         BigInt       @map("user_id")
  collaboratorId BigInt       @map("collaborator_id")
  notes          String?      @db.Text
  createdAt      DateTime     @default(now()) @map("created_at")

  user           User         @relation(fields: [userId], references: [userId], onDelete: Cascade)
  collaborator   Collaborator @relation(fields: [collaboratorId], references: [collaboratorId], onDelete: Cascade)

  @@unique([userId, collaboratorId])
  @@map("user_favorite_collaborators")
}

model Route {
  routeId                  BigInt      @id @default(autoincrement()) @map("route_id")
  userId                   BigInt      @map("user_id")
  routeName                String      @map("route_name") @db.VarChar(255)
  description              String?     @db.Text
  routeType                RouteType?  @map("route_type")
  isShared                 Boolean     @default(false) @map("is_shared")
  privacy                  PrivacyType @default(private)
  startLocationName        String?     @map("start_location_name") @db.VarChar(255)
  startLatitude            Decimal?    @map("start_latitude") @db.Decimal(10, 8)
  startLongitude           Decimal?    @map("start_longitude") @db.Decimal(11, 8)
  endLocationName          String?     @map("end_location_name") @db.VarChar(255)
  endLatitude              Decimal?    @map("end_latitude") @db.Decimal(10, 8)
  endLongitude             Decimal?    @map("end_longitude") @db.Decimal(11, 8)
  distanceKm               Decimal?    @map("distance_km") @db.Decimal(8, 2)
  elevationGainM           Decimal?    @map("elevation_gain_m") @db.Decimal(8, 2)
  estimatedDurationMinutes Int?        @map("estimated_duration_minutes")
  difficulty               DifficultyLevel?
  routeData                Json?       @map("route_data")
  terrainType              TerrainType? @map("terrain_type")
  isLoop                   Boolean     @default(false) @map("is_loop")
  surfaceTypes             Json?       @map("surface_types")
  landmarks                Json?
  imageUrl                 String?     @map("image_url") @db.VarChar(500)
  viewCount                Int         @default(0) @map("view_count")
  likeCount                Int         @default(0) @map("like_count")
  createdAt                DateTime    @default(now()) @map("created_at")
  updatedAt                DateTime    @updatedAt @map("updated_at")

  user                     User        @relation(fields: [userId], references: [userId], onDelete: Cascade)
  activities               RouteActivity[]
  shares                   RouteShare[]

  @@map("routes")
}

model RouteShare {
  shareId          BigInt   @id @default(autoincrement()) @map("share_id")
  routeId          BigInt   @map("route_id")
  sharedByUserId   BigInt   @map("shared_by_user_id")
  sharedWithUserId BigInt   @map("shared_with_user_id")
  message          String?  @db.Text
  sharedAt         DateTime @default(now()) @map("shared_at")

  route            Route    @relation(fields: [routeId], references: [routeId], onDelete: Cascade)
  sharedBy         User     @relation("SharedBy", fields: [sharedByUserId], references: [userId], onDelete: Cascade)
  sharedWith       User     @relation("SharedWith", fields: [sharedWithUserId], references: [userId], onDelete: Cascade)

  @@map("route_shares")
}

model RouteActivity {
  activityId       BigInt   @id @default(autoincrement()) @map("activity_id")
  routeId          BigInt   @map("route_id")
  userId           BigInt   @map("user_id")
  activityDate     DateTime @map("activity_date")
  durationMinutes  Int?     @map("duration_minutes")
  distanceKm       Decimal? @map("distance_km") @db.Decimal(8, 2)
  averagePace      String?  @map("average_pace") @db.VarChar(20)
  averageSpeedKmh  Decimal? @map("average_speed_kmh") @db.Decimal(5, 2)
  maxSpeedKmh      Decimal? @map("max_speed_kmh") @db.Decimal(5, 2)
  caloriesBurned   Decimal? @map("calories_burned") @db.Decimal(6, 2)
  averageHeartRate Int?     @map("average_heart_rate")
  maxHeartRate     Int?     @map("max_heart_rate")
  elevationGainM   Decimal? @map("elevation_gain_m") @db.Decimal(8, 2)
  weatherConditions String? @map("weather_conditions") @db.VarChar(100)
  temperatureCelsius Decimal? @map("temperature_celsius") @db.Decimal(4, 1)
  notes            String?  @db.Text
  gpsData          Json?    @map("gps_data")
  photos           Json?
  isShared         Boolean  @default(false) @map("is_shared")
  createdAt        DateTime @default(now()) @map("created_at")

  route            Route    @relation(fields: [routeId], references: [routeId], onDelete: Cascade)
  user             User     @relation(fields: [userId], references: [userId], onDelete: Cascade)

  @@map("route_activities")
}

model CustomSchedule {
  scheduleId        BigInt        @id @default(autoincrement()) @map("schedule_id")
  userId            BigInt        @map("user_id")
  scheduleName      String        @map("schedule_name") @db.VarChar(255)
  description       String?       @db.Text
  scheduleType      ScheduleType?
  isVr              Boolean       @default(false) @map("is_vr")
  startDate         DateTime?     @map("start_date") @db.Date
  endDate           DateTime?     @map("end_date") @db.Date
  recurrencePattern Json?         @map("recurrence_pattern")
  isActive          Boolean       @default(true) @map("is_active")
  createdAt         DateTime      @default(now()) @map("created_at")
  updatedAt         DateTime      @updatedAt @map("updated_at")

  user              User          @relation(fields: [userId], references: [userId], onDelete: Cascade)
  items             ScheduleItem[]

  @@map("custom_schedules")
}

model ScheduleItem {
  itemId                BigInt         @id @default(autoincrement()) @map("item_id")
  scheduleId            BigInt         @map("schedule_id")
  itemType              ItemType?      @map("item_type")
  title                 String         @db.VarChar(255)
  description           String?        @db.Text
  scheduledDate         DateTime       @map("scheduled_date") @db.Date
  scheduledTime         DateTime?      @map("scheduled_time") @db.Time
  durationMinutes       Int?           @map("duration_minutes")
  location              String?        @db.VarChar(255)
  isVr                  Boolean        @default(false) @map("is_vr")
  relatedEntityType     String?        @map("related_entity_type") @db.VarChar(50)
  relatedEntityId       BigInt?        @map("related_entity_id")
  status                ItemStatus     @default(scheduled)
  reminderMinutesBefore Int?           @map("reminder_minutes_before")
  notes                 String?        @db.Text
  createdAt             DateTime       @default(now()) @map("created_at")
  updatedAt             DateTime       @updatedAt @map("updated_at")

  schedule              CustomSchedule @relation(fields: [scheduleId], references: [scheduleId], onDelete: Cascade)

  @@map("schedule_items")
}

model UserMetric {
  metricId               BigInt   @id @default(autoincrement()) @map("metric_id")
  userId                 BigInt   @map("user_id")
  metricDate             DateTime @map("metric_date") @db.Date
  weightKg               Decimal? @map("weight_kg") @db.Decimal(5, 2)
  bodyFatPercentage      Decimal? @map("body_fat_percentage") @db.Decimal(4, 2)
  muscleMassKg           Decimal? @map("muscle_mass_kg") @db.Decimal(5, 2)
  bmi                    Decimal? @db.Decimal(4, 2)
  waistCm                Decimal? @map("waist_cm") @db.Decimal(5, 2)
  chestCm                Decimal? @map("chest_cm") @db.Decimal(5, 2)
  armsCm                 Decimal? @map("arms_cm") @db.Decimal(5, 2)
  thighsCm               Decimal? @map("thighs_cm") @db.Decimal(5, 2)
  restingHeartRate       Int?     @map("resting_heart_rate")
  bloodPressureSystolic  Int?     @map("blood_pressure_systolic")
  bloodPressureDiastolic Int?     @map("blood_pressure_diastolic")
  vo2Max                 Decimal? @map("vo2_max") @db.Decimal(5, 2)
  sleepHours             Decimal? @map("sleep_hours") @db.Decimal(4, 2)
  waterIntakeLiters      Decimal? @map("water_intake_liters") @db.Decimal(4, 2)
  stressLevel            Int?     @map("stress_level")
  energyLevel            Int?     @map("energy_level")
  notes                  String?  @db.Text
  createdAt              DateTime @default(now()) @map("created_at")

  user                   User     @relation(fields: [userId], references: [userId], onDelete: Cascade)

  @@unique([userId, metricDate])
  @@map("user_metrics")
}

model Notification {
  notificationId   BigInt               @id @default(autoincrement()) @map("notification_id")
  userId           BigInt               @map("user_id")
  notificationType NotificationType     @map("notification_type")
  title            String               @db.VarChar(255)
  message          String?              @db.Text
  isRead           Boolean              @default(false) @map("is_read")
  actionUrl        String?              @map("action_url") @db.VarChar(500)
  relatedEntityType String?             @map("related_entity_type") @db.VarChar(50)
  relatedEntityId  BigInt?              @map("related_entity_id")
  priority         NotificationPriority @default(normal)
  expiresAt        DateTime?            @map("expires_at")
  readAt           DateTime?            @map("read_at")
  createdAt        DateTime             @default(now()) @map("created_at")

  user             User                 @relation(fields: [userId], references: [userId], onDelete: Cascade)

  @@map("notifications")
}

model Achievement {
  achievementId   BigInt               @id @default(autoincrement()) @map("achievement_id")
  achievementName String               @map("achievement_name") @db.VarChar(255)
  description     String?              @db.Text
  category        AchievementCategory?
  criteria        Json?
  badgeImageUrl   String?              @map("badge_image_url") @db.VarChar(500)
  points          Int                  @default(0)
  rarity          RarityType           @default(common)
  isActive        Boolean              @default(true) @map("is_active")
  createdAt       DateTime             @default(now()) @map("created_at")

  userAchievements UserAchievement[]

  @@map("achievements")
}

model UserAchievement {
  userAchievementId  BigInt      @id @default(autoincrement()) @map("user_achievement_id")
  userId             BigInt      @map("user_id")
  achievementId      BigInt      @map("achievement_id")
  unlockedAt         DateTime    @default(now()) @map("unlocked_at")
  progressPercentage Int         @default(100) @map("progress_percentage")

  user               User        @relation(fields: [userId], references: [userId], onDelete: Cascade)
  achievement        Achievement @relation(fields: [achievementId], references: [achievementId], onDelete: Cascade)

  @@unique([userId, achievementId])
  @@map("user_achievements")
}

model UserSession {
  sessionId      String   @id @map("session_id") @db.VarChar(255)
  userId         BigInt   @map("user_id")
  deviceType     String?  @map("device_type") @db.VarChar(100)
  deviceName     String?  @map("device_name") @db.VarChar(255)
  os             String?  @db.VarChar(100)
  browser        String?  @db.VarChar(100)
  ipAddress      String?  @map("ip_address") @db.VarChar(45)
  locationCountry String? @map("location_country") @db.VarChar(100)
  locationCity   String?  @map("location_city") @db.VarChar(100)
  isActive       Boolean  @default(true) @map("is_active")
  lastActivityAt DateTime @default(now()) @map("last_activity_at")
  createdAt      DateTime @default(now()) @map("created_at")
  expiresAt      DateTime @map("expires_at")

  user           User     @relation(fields: [userId], references: [userId], onDelete: Cascade)

  @@map("user_sessions")
}
EOF
echo "✅ prisma/schema.prisma (complet - 30 modèles)"

echo ""
echo "============================================="
echo "✅ Fichiers Prisma générés !"
echo "============================================="
echo ""
echo "🎯 Lance maintenant ces commandes :"
echo ""
echo "  1. npx prisma generate"
echo "  2. npx prisma migrate dev --name init"
echo "  3. npx prisma studio"
echo ""