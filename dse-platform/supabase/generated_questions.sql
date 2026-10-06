CREATE TABLE generated_questions (
  id                  BIGSERIAL PRIMARY KEY,
  subject             TEXT NOT NULL DEFAULT 'math',
  topic               TEXT NOT NULL,
  skill_id            BIGINT REFERENCES topic_skills(id) ON DELETE SET NULL,
  question_text       TEXT NOT NULL,
  answer_text         TEXT NOT NULL,
  explanation         TEXT,
  model_used          TEXT,
  raw_ai_response     JSONB,
  created_at          TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_generated_questions_topic 
  ON generated_questions (subject, topic);
CREATE INDEX idx_generated_questions_skill 
  ON generated_questions (skill_id);