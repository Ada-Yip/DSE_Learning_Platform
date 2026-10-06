CREATE TABLE past_papers (
  id            BIGSERIAL PRIMARY KEY,
  subject       TEXT NOT NULL DEFAULT 'math',
  topic         TEXT NOT NULL,
  exam_type     TEXT,
  year          INTEGER,
  paper         TEXT,
  question_no   TEXT,
  question_text TEXT NOT NULL,
  answer_text   TEXT,
  image_url     TEXT,
  source_file   TEXT,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_past_papers_topic 
  ON past_papers (subject, topic);

ALTER TABLE past_papers 
  ADD CONSTRAINT unique_past_paper 
  UNIQUE (exam_type, year, paper, question_no);