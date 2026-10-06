-- RLS policies for DSE Learning Platform
-- Run this after 01-schema.sql

ALTER TABLE topic_skills ENABLE ROW LEVEL SECURITY;
ALTER TABLE past_papers ENABLE ROW LEVEL SECURITY;
ALTER TABLE generated_questions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read on topic_skills"
  ON topic_skills FOR SELECT USING (true);

CREATE POLICY "Allow public read on past_papers"
  ON past_papers FOR SELECT USING (true);

CREATE POLICY "Allow public read on generated_questions"
  ON generated_questions FOR SELECT USING (true);

CREATE POLICY "Allow public insert on generated_questions"
  ON generated_questions FOR INSERT WITH CHECK (true);