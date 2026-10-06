CREATE TABLE topic_skills (
  id                BIGSERIAL PRIMARY KEY,
  subject           TEXT NOT NULL DEFAULT 'math',
  topic             TEXT NOT NULL,
  skill_name        TEXT NOT NULL,
  description       TEXT NOT NULL,
  question_pattern  TEXT,
  common_traps      TEXT,
  example_prompt    TEXT,
  created_at        TIMESTAMPTZ DEFAULT NOW(),
  
  UNIQUE (subject, topic, skill_name)
);